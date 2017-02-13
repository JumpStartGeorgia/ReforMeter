class Admin::ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /admin/reports
  # GET /admin/reports.json
  def index
    @reports = Report.sorted
  end

  # GET /admin/reports/1
  # GET /admin/reports/1.json
  def show
  end

  # GET /admin/reports/new
  def new
    @report = Report.new
  end

  # GET /admin/reports/1/edit
  def edit
    set_date
  end

  # POST /admin/reports
  # POST /admin/reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to admin_reports_path, notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.report', count: 1)) }
        format.json { render :show, status: :created, location: @report }
      else
        set_date
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/reports/1
  # PATCH/PUT /admin/reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to admin_reports_path, notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.report', count: 1)) }
        format.json { render :show, status: :ok, location: @report }
      else
        set_date
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/reports/1
  # DELETE /admin/reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to admin_reports_url, notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.report', count: 1)) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      permitted = Report.globalize_attribute_names + [
        :report_en, :report_ka, :is_active, :report_date
      ]
      params.require(:report).permit(*permitted)
    end

    # set the date for the datepicker
    def set_date
      gon.report_date = @report.report_date.strftime('%m/%d/%Y %H:%M') if !@report.report_date.nil?
    end    
end
