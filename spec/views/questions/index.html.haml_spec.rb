require 'rails_helper'

RSpec.describe "questions/index", :type => :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        :name => "MyText",
        :answer_type => 1,
        :answer_array => "MyText"
      ),
      Question.create!(
        :name => "MyText",
        :answer_type => 1,
        :answer_array => "MyText"
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
