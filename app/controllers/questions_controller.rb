class QuestionsController < ApplicationController
  before_filter :check_auth
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :check_presentation, only: [:index, :new]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.where(:presentation => @presentation).full.order_position.all
  end

  # GET /checkAnswer/1
  # GET /checkAnswer/1.json
  def show
  end

  def checkAnswer
    questionID = params[:questionID].to_i
    answer     = params[:answer]
    question = Question.find(questionID)
    question.checkAnswer(answer)
    a = Answer.new
    a.text = answer
    a.question = question
    a.user   = @current_user
    a.save
    respond_to do |format|
      if question.checkAnswer(answer)
        msg = { :message => "Правильно!", :status => 'OK' }
      else
        msg = { :message => "Неверный ответ!", :status => 'WRONG' }
      end
      format.json  { render json: msg }
    end
  end

  # GET /questions/new
  def new
    @question = Question.new
    @question.presentation = @presentation
    @question.position     = 1
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to edit_question_path(@question), notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to edit_question_path(@question), notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @presentation_id = @question.presentation.id
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_path(:presentation_id => @presentation_id), notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end
    def check_presentation
      @presentation_id = params[:presentation_id].to_i
      if @presentation_id <= 0
        respond_to do |format|
          format.html { redirect_to root_url, notice: 'Вопросы можно создавать только для конкретной презентации' }
        end
      else
        @presentation = Presentation.find @presentation_id
        if @presentation.nil?
          respond_to do |format|
            format.html { redirect_to root_url, notice: 'Такой презентации не существует' }
          end
        end
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      # удаляем пустые элементы хэ
      if !params[:question][:answer_array].nil?
        params[:question][:answer_array].each do |key, value|
          value = value["0"] if value.is_a?(Hash) #для тип ответа - выбор из списка
          if key.strip.length == 0 || value.strip.length == 0
            params[:question][:answer_array].delete(key)
          end
        end
      end
      params.require(:question).permit(:name, :answer_type, :position, :presentation, :presentation_id).tap do |whitelisted|
        whitelisted[:answer_array] = params[:question][:answer_array]
      end
    end

end
