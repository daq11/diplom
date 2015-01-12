require 'rails_helper'

RSpec.describe "questions/show", :type => :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :name => "MyText",
      :answer_type => 1,
      :answer_array => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/MyText/)
  end
end
