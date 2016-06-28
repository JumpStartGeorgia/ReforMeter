class Admin::ExpertSurveysController < ApplicationController
  before_action :authenticate_user!
  before_action :get_quarter
  before_action :set_expert_survey, only: [:show, :edit, :update, :destroy]
  before_action :load_experts, only: [:new, :edit, :create, :update]
  authorize_resource

  # GET /admin/expert_surveys
  # GET /admin/expert_surveys.json
  def index
    @expert_surveys = ExpertSurvey.all
  end

  # GET /admin/expert_surveys/1
  # GET /admin/expert_surveys/1.json
  def show

    @methodology_expert = PageContent.find_by(name: 'methodology_expert')
    @news = News.by_expert_quarter(@quarter.id)

    gon.chart_download_icon = highchart_download_icon
    gon.change_icons = view_context.change_icons

    gon.charts = [
      Quarter.expert_survey_data_for_charting(id: 'expert-history', is_published: false), {
        id: 'overall',
        title: I18n.t('shared.categories.overall'),
        score: @quarter.expert_survey.overall_score.to_f,
        change: @quarter.expert_survey.overall_change
      }, {
        id: 'performance',
        title: I18n.t('shared.categories.performance'),
        score: @quarter.expert_survey.category1_score.to_f,
        change: @quarter.expert_survey.category1_change
      }, {
        id: 'goals',
        title: I18n.t('shared.categories.goals'),
        score: @quarter.expert_survey.category2_score.to_f,
        change: @quarter.expert_survey.category2_change
      }, {
        id: 'progress',
        title: I18n.t('shared.categories.progress'),
        score: @quarter.expert_survey.category3_score.to_f,
        change: @quarter.expert_survey.category3_change
      }
    ]

  end

  # GET /admin/expert_surveys/new
  def new
    # if survey already exsts for this quarter, load it
    # - there can be only one survey per quarter
    survey = ExpertSurvey.where(quarter: @quarter.id).first
    if survey.present?
      redirect_to edit_admin_quarter_expert_survey_path(quarter_id: @quarter.slug)
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
        format.html { redirect_to admin_quarter_expert_survey_path(quarter_id: @quarter.slug), notice: t('shared.msgs.success_created',
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
        format.html { redirect_to admin_quarter_expert_survey_path(quarter_id: @quarter.slug), notice: t('shared.msgs.success_updated',
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
      # @expert_survey = ExpertSurvey.find(params[:id])
      @expert_survey = @quarter.expert_survey
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
