json.array!(@questions) do |question|
  json.extract! question, :id, :name, :answer_type, :answer_array
  json.url question_url(question, format: :json)
end
