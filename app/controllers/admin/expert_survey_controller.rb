class Admin::ExpertSurveyController < ApplicationController
  before_action :set_expert_survey, only: [:show, :edit, :update, :destroy]
  before_action :get_quarter
  before_action :load_experts, only: [:new, :edit, :create, :update]

  # GET /admin/expert_surveys
  # GET /admin/expert_surveys.json
  def index
    @expert_surveys = ExpertSurvey.all
  end

  # GET /admin/expert_surveys/1
  # GET /admin/expert_surveys/1.json
  def show
  end

  # GET /admin/expert_surveys/new
  def new
    # if survey already exsts for this quarter, load it
    # - there can be only one survey per quarter
    survey = ExpertSurvey.where(quarter: @quarter.id)
    if survey
      redirect_to edit_admin_quarter_expert_survey_path(quarter_id: @quarter.slug, id: survey.id)
    end

    @expert_survey = ExpertSurvey.new
  end

  # GET /admin/expert_surveys/1/edit
  def edit
  end

  # POST /admin/expert_surveys
  # POST /admin/expert_surveys.json
  def create
    @expert_survey = ExpertSurvey.new(expert_survey_params)

    respond_to do |format|
      if @expert_survey.save
        format.html { redirect_to admin_quarters_path(q: @quarter.slug), notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.expert_survey', count: 1)) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/expert_surveys/1
  # PATCH/PUT /admin/expert_surveys/1.json
  def update
    respond_to do |format|
      if @expert_survey.update(expert_survey_params)
        format.html { redirect_to admin_quarters_path(q: @quarter.slug), notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.expert_survey', count: 1)) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/expert_surveys/1
  # DELETE /admin/expert_surveys/1.json
  def destroy
    @expert_survey.destroy
    respond_to do |format|
      format.html { redirect_to admin_quarters_url(q: @quarter.slug), notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.expert_survey', count: 1)) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expert_survey
      @expert_survey = ExpertSurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expert_survey_params
      permitted = ExpertSurvey.globalize_attribute_names + [
        :quarter_id, :overall_score, :category1_score, :category2_score, :category3_score, expert_ids: []
      ]
      params.require(:expert_survey).permit(*permitted)
    end

    def load_experts
      @experts = Expert.active#.sorted
    end
end
