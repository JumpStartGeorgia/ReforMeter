class AssignSurveysToVerdict < ActiveRecord::Migration
  def up
    # create a verdict
    verdict = Verdict.create(title_en: '2017 Phase 1', title_ka: '2017 Phase 1', time_period: '2017-01-01')
    
    # assign surveys to this verdict
    q = Quarter.latest
    if q.present?
      q.reform_surveys.update_all(verdict_id: verdict.id)
    end

    # delete all reform surveys without a verdict_id
    ReformSurvey.where(verdict_id: nil).destroy_all

  end

  def down
    ReformSurvey.update_all(verdict_id: nil)
    Verdict.destroy_all
  end
end
