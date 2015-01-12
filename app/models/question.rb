class Question < ActiveRecord::Base
  @@question_type = ['ручной ввод', 'выбор из списка']
  belongs_to :presentation
  has_many   :answers

  serialize :answer_array
  validates :name, presence: true
  validates :answer_array, presence: true
  validates :answer_type, :inclusion => {:in => [0, 1]} # 0 - ручной ввод, 1 - выбор из списка
  validates :answer_type, numericality: { only_integer: true }
  validates :position, numericality: { only_integer: true, :greater_than => 0 }
  validates :presentation, :presence => true
  validate  :minNotRightAnswerCount
  validate  :oneQuestionOnePositionForPresentation

  scope :full, ->{includes(:presentation)}
  scope :order_position, ->{order(:position)}
  public

  def self.QuestionTypeArray
    @@question_type
  end

  def checkAnswer(answer)
    self.getRightAnswerList.include?(answer)
  end

  def answerTypeHumanString
    @@question_type[self.answer_type]
  end

  def getFullAnswerList
    result = []
    if(self.answer_type == 0)
      self.answer_array.each do |k, v|
        result << v
      end
    elsif(self.answer_type == 1)
      self.answer_array.each do |k, v|
        result << v['0']
      end
    end
    result
  end

  def getRightAnswerList
    result = []
    if(self.answer_type == 0)
      self.answer_array.each do |k, v|
        result << v
      end
    elsif(self.answer_type == 1)
      self.answer_array.each do |k, v|
        result << v['0'] if v['1'] == 'right'
      end
    end
    result
  end

  def notRightAnswerList
    result = []
    if(self.answer_type == 1)
      self.answer_array.each do |k, v|
        result << v['0'] if v['1'].nil?
      end
    end
    result
  end

  # отвечал ли пользователь правильно на вопрос
  def userHaveRightAnswer(user)
    return false if user.nil?
    if user
      answers = Answer.where(:user => user, :question => self).all
      answers.each do |answer|
        return true if self.checkAnswer answer.text
      end
    end
    false
  end
  private
  def minNotRightAnswerCount
    # если тип ответа - выбор из списка
    # то количество неправильных ответов должно быть минимум 4
    if self.answer_type == 1 && self.notRightAnswerList.length < 4
      errors.add(:answer_array, 'Неправильных ответов должно быть минимум 4')
    end
  end

  def oneQuestionOnePositionForPresentation
    # для одной презентации на одной позиции только 1 вопрос
      q = Question.where(:presentation => self.presentation, :position => self.position).first
      if !q.nil?
        if  q.id != self.id
          errors.add(:position, 'указанного в этом вопросе уже есть вопрос')
        end
      end
  end
end
