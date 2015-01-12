class PresentationsController < ApplicationController
  before_filter :check_auth
  before_filter :check_tutor, except: [:show, :reload]
  before_filter :set_presentation, only: [:show, :edit, :update, :destroy]
  before_filter :check_owner, only: [:edit, :update, :destroy]

  # type:
  #       nil или none
  #       my
  #       old
  def index
    @presentations =
      case params[:type]
      when 'my'
        @old_count = Presentation.old_presentations(@current_user.id).count
        Presentation.where('user_id = ?', @current_user.id).order('updated_at DESC').page(params[:page])
      when 'old'
        Presentation.old_presentations(@current_user.id).order('updated_at DESC').page(params[:page])
      else
        Presentation.all.order('updated_at DESC').page(params[:page])
      end
   end

  def search
    @presentations =
      if params[:type] == 'my'
        Presentation.search params['search'], where: {user_id: @current_user.id}, page: params[:page], per_page: 15
      else
        Presentation.search params['search'], page: params[:page], per_page: 15
      end
    render 'index'
  end

  def show
    @slide    = params[:slide].to_i
    @section  = @presentation.document.sections[@slide]
    @question = Question.where(:presentation => @presentation, :position => @slide ).first
    unless @question.nil?
       if @question.userHaveRightAnswer @current_user
         @question = nil
       else
         @no_next = true
       end
    end
    respond_to do |format|
      request.format = :html if request.format != :json
      format.json do
        @presentation.update_column(:last_open_slide, params[:value].to_i)
        render json: (params[:type] == 'hide' ? 'background' : 'none').to_json
      end
      format.html do
        unless @question.nil?

        else
          if params[:name].nil?
            # Собственно слайды
            if !@current_user.roles.nil? && @current_user.roles.include?('tutor')
              @tutor = true
              if @presentation.private?
                @background = 'green'
              else
                if @presentation.auto_open
                  @presentation.update_column(:last_open_slide, @slide)
                else
                  if @slide > @presentation.last_open_slide
                    @background = 'gray'
                  end
                end
              end
            elsif (@presentation.groups & @current_user.groups).empty? ||
                @slide > @presentation.last_open_slide
              @section.source = ''
            end
            if @slide >= @presentation.document.sections.count ||
                @presentation.last_open_slide <= @slide
              @no_next = true
            end
            if @tutor && @slide < @presentation.document.sections.count - 1
              @next_source = @presentation.document.sections[@slide+1].source
            end
          else
            # Графические изображения или css-файлы
            d_id = @presentation.document_id
            afile = (Afile.where(document_id: d_id, path: "files_#{params[:type]}_#{params[:name]}.#{params[:format]}")).first
            send_data afile.source, disposition: "inline"
          end
        end
      end
    end
  end

  def reload
    p = Presentation.find(params['id'])
    render json: {text: p.last_open_slide >= params['slide'].to_i ?
      'yes' : 'no'}
  end

  def new
    @document = Document.find(params[:document_id])
    @presentation = Presentation.new(document_id: @document.id, 
                                     comment: @document.comment,
                                     groups_string: '',
                                     last_open_slide: 0, auto_open: true)
    render 'edit'
  end

  def create
    @presentation = 
      Presentation.new(document_id: params[:document_id], 
                       comment: params[:presentation][:comment],
                       user_id: @current_user.id,
                       groups: params[:presentation][:groups_string].split,
                       last_open_slide: params[:presentation][:last_open_slide],
                       auto_open: params[:presentation][:auto_open] == '1')
    if @presentation.save
      redirect_to presentations_path
    else
      @presentation.groups_string =  params[:presentation][:groups_string]
      render 'edit'
    end
  end

  def edit
    @document = @presentation.document
    @presentation.groups_string = @presentation.groups.join(' ')
  end

  def update
    respond_to do |format|
      format.json do
        @presentation.update_column(:last_open_slide, params[:value].to_i)
        render json: {data: params[:type] == 'hide' ? 'background' : 'none'}
      end
      format.html do
        @presentation.comment = params[:presentation][:comment]
        @presentation.groups = params[:presentation][:groups_string].split
        @presentation.last_open_slide = params[:presentation][:last_open_slide]
        @presentation.auto_open = params[:presentation][:auto_open] == '1'
        if @presentation.save
          redirect_to presentations_path
        else
          @presentation.groups_string =  params[:presentation][:groups_string]
          render 'edit'
        end
      end
    end
  end

  # Нельзя удалять презентацию 'для преподавателей' (вместе с которой
  # необходимо удалять и документ), если есть иные презентации этого
  # документа!!!
  def destroy
    if @presentation.private?
      if @presentation.document.presentations.size == 1
        @presentation.document.delete
        @presentation.delete
      else
        flash[:danger] = 'Эту презентацию можно удалить только после удаления всех её «братьев»'
      end
    else
      @presentation.delete
    end
    redirect_to presentations_path
  end

  private

  def check_tutor
    if @current_user.roles.nil? || !@current_user.roles.include?('tutor')
      render text: 'Доступ запрещён'
    end
  end

  def set_presentation
    @presentation = Presentation.find(params[:id])
  end

  def owner?
    @presentation.user == @current_user || @current_user.roles =~ /admin/
  end

  def check_owner
    if !owner?
      render text: 'Операция запрещена'
    end
  end

end
