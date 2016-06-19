json.array!(@admin_expert_surveys) do |admin_expert_survey|
  json.extract! admin_expert_survey, :id
  json.url admin_expert_survey_url(admin_expert_survey, format: :json)
end
