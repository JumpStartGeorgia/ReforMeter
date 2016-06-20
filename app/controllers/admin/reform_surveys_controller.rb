class Admin::ReformSurveysController < ApplicationController
  before_action :set_reform_survey, only: [:new, :show, :edit, :update, :destroy]
  before_action :get_quarter
  before_action :load_reforms, only: [:new, :edit, :create, :update]

  # GET /admin/reform_surveys
  # GET /admin/reform_surveys.json
  def index
    @reform_surveys = ReformSurvey.all
  end

  # GET /admin/reform_surveys/1
  # GET /admin/reform_surveys/1.json
  def show
  end

  # GET /admin/reform_surveys/new
  def new
    # if all reforms are already evaluated, stop
    if @reforms.length > 0 && @survey_reforms.length > 0
      found_all = true
      @reforms.each do |reform|
        found_all = @survey_reforms.select{|x| x.reform_id == reform.id}.length > 0
        break if !found_all
      end
      if found_all
        redirect_to admin_quarters_path(q: @quarter.slug),
                alert: t('shared.msgs.all_reform_surveys_exist', quarter: @quarter.time_period)
      end
    end
  end

  # GET /admin/reform_surveys/1/edit
  def edit
  end

  # POST /admin/reform_surveys
  # POST /admin/reform_surveys.json
  def create
    @reform_survey = ReformSurvey.new(reform_survey_params)

    respond_to do |format|
      if @reform_survey.save
        format.html { redirect_to admin_quarters_path(q: @quarter.slug), notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.reform_survey', count: 1)) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/reform_surveys/1
  # PATCH/PUT /admin/reform_surveys/1.json
  def update
    respond_to do |format|
      if @reform_survey.update(reform_survey_params)
        format.html { redirect_to admin_quarters_path(q: @quarter.slug), notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.reform_survey', count: 1)) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/reform_surveys/1
  # DELETE /admin/reform_surveys/1.json
  def destroy
    @reform_survey.destroy
    respond_to do |format|
      format.html { redirect_to admin_quarters_url(q: @quarter.slug), notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.reform_survey', count: 1)) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reform_survey
      @reform_survey = params[:action] == 'new' ? ReformSurvey.new : ReformSurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reform_survey_params
      permitted = ReformSurvey.globalize_attribute_names + [
        :quarter_id, :reform_id,
        :government_overall_score, :government_category1_score, :government_category2_score, :government_category3_score, :government_category4_score,
        :stakeholder_overall_score, :stakeholder_category1_score, :stakeholder_category2_score, :stakeholder_category3_score
      ]
      params.require(:reform_survey).permit(*permitted)
    end

    def load_reforms
      # ge all reforms
      @reforms = Reform.active#.sorted

      # get all reforms that already have a survey for this quarter
      @survey_reforms = ReformSurvey.in_quarter(@quarter.id)
      @survey_reforms = @survey_reforms.not_in_reform(@reform_survey.reform_id) if @reform_survey.reform_id
    end
end
