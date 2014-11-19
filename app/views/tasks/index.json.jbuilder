json.array!(@tasks) do |task|
  json.extract! task, :id, :question, :answer
  json.url task_url(task, format: :json)
end
