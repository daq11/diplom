require 'rails_helper'

RSpec.describe "questions/new", :type => :view do
  before(:each) do
    assign(:question, Question.new(
      :name => "MyText",
      :answer_type => 1,
      :answer_array => "MyText"
    ))
  end

  it "renders new question form" do
    render

    assert_select "form[action=?][method=?]", questions_path, "post" do

      assert_select "textarea#question_name[name=?]", "question[name]"

      assert_select "input#question_answer_type[name=?]", "question[answer_type]"

      assert_select "textarea#question_answer_array[name=?]", "question[answer_array]"
    end
  end
end
