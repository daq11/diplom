class Presentation < ActiveRecord::Base
  belongs_to :document
  belongs_to :user
  attr_accessor :groups_string
  has_many :questions, :dependent => :delete_all
  serialize :groups, Array

  validates_each :groups do |record, attr, value|
    if value.size == 0
      record.errors.add(:base, 'Необходимо указать одну или несколько групп')
    end
    value.each do |v|
      unless Group.all.map(&:name).include?(v)
        record.errors.add(:base, "Неизвестная группа «#{v}»")
      end
    end
  end
  
  validates :last_open_slide, numericality: {only_integer: true,
    greater_than_or_equal_to: 0}

  searchkick language: "Russian"
  def search_data
    as_json only: [:comment, :body]
    {
      comment: comment,
      body: body
    }
  end

  def private?
    self.groups.size == 0
  end

  def for_groups
    'для ' +
      (private? ? 'преподавателей' :
      ('групп' + (groups.size == 1 ? 'ы ' : ' ') + groups.join(', ')))
  end

  def body
    document.sections.map{|s| s.source}.join
  end

  def prev_url(slide)
    "/presentations/#{id}/#{slide-1}/show"
  end

  def next_url(slide)
    "/presentations/#{id}/#{slide+1}/show"
  end

  def Presentation.old_presentations(user_id)
    Presentation.where('user_id = ? AND updated_at < ?', user_id,
                       Time.now.advance(days: -15))
  end
end
