class Admin::ExpertSurveysController < ApplicationController
  before_action :set_admin_expert_survey, only: [:show, :edit, :update, :destroy]

  # GET /admin/expert_surveys
  # GET /admin/expert_surveys.json
  def index
    @admin_expert_surveys = Admin::ExpertSurvey.all
  end

  # GET /admin/expert_surveys/1
  # GET /admin/expert_surveys/1.json
  def show
  end

  # GET /admin/expert_surveys/new
  def new
    @admin_expert_survey = Admin::ExpertSurvey.new
  end

  # GET /admin/expert_surveys/1/edit
  def edit
  end

  # POST /admin/expert_surveys
  # POST /admin/expert_surveys.json
  def create
    @admin_expert_survey = Admin::ExpertSurvey.new(admin_expert_survey_params)

    respond_to do |format|
      if @admin_expert_survey.save
        format.html { redirect_to @admin_expert_survey, notice: 'Expert survey was successfully created.' }
        format.json { render :show, status: :created, location: @admin_expert_survey }
      else
        format.html { render :new }
        format.json { render json: @admin_expert_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/expert_surveys/1
  # PATCH/PUT /admin/expert_surveys/1.json
  def update
    respond_to do |format|
      if @admin_expert_survey.update(admin_expert_survey_params)
        format.html { redirect_to @admin_expert_survey, notice: 'Expert survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_expert_survey }
      else
        format.html { render :edit }
        format.json { render json: @admin_expert_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/expert_surveys/1
  # DELETE /admin/expert_surveys/1.json
  def destroy
    @admin_expert_survey.destroy
    respond_to do |format|
      format.html { redirect_to admin_expert_surveys_url, notice: 'Expert survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_expert_survey
      @admin_expert_survey = Admin::ExpertSurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_expert_survey_params
      params.fetch(:admin_expert_survey, {})
    end
end
