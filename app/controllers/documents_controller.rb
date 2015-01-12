class DocumentsController < ApplicationController
  protect_from_forgery except: [:create, :update]
  before_filter :http_auth

  def create
    respond_to do |format|
      format.json do
        d = Document.new(comment: params['comment'], 
                         user: User.find_by_login(params['login']),
                         material_id: params['material_id'])
        d.create_sections_and_afiles(params['body'].tempfile)
        if d.save
          p = Presentation.new(document_id: d.id, user_id: d.user_id,
                               comment: d.comment, groups: [], 
                               last_open_slide: 0, auto_open: true)
          p.save(validate: false)
          render json: {id: d.id}
        else
          render json: {error: d.errors.inspect}
        end
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        begin
          @document = Document.find(params[:id])
        rescue
          render json: {error: 'Ранее загруженная на edu_online презентация не найдена. Возможно, Вам следует удалить и вновь создать презентацию (эта операция безопасна), а затем загрузить её на edu_online.'} and return
        end
        count = @document.sections.count
        @document.sections.delete_all
        @document.afiles.delete_all
        @document.create_sections_and_afiles(params['body'].tempfile)
        if @document.sections.count != count
          render json: {error: 'Будьте внимательны! В обновлённом варианте презентации изменилось количество слайдов.'}
        else
          render json: {id: @document.id}
        end
      end
    end
  end

  private

  def http_auth
    authenticate_or_request_with_http_basic do |u, p|
      u == 'roganov' && p == 'online'
    end
  end

end
