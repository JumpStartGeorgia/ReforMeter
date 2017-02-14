class Admin::VerdictsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_verdict, only: [:show, :edit, :update, :destroy, :publish, :unpublish]
  authorize_resource

  # GET /admin/verdicts
  # GET /admin/verdicts.json
  def index
    @verdicts = Verdict.recent.all_verdicts_array
    params[:v] = nil if !@verdicts.map{|x| x[1]}.include?(params[:v])
    params[:v] = @verdicts[0][1] if params[:v].nil? && @verdicts.present?
    @verdict = Verdict.with_reform_surveys.with_news.friendly.find(params[:v]) if params[:v].present?
  end

  # GET /admin/verdicts/1
  # GET /admin/verdicts/1.json
  def show
  end

  # GET /admin/verdicts/new
  def new
    @verdict = Verdict.new
  end

  # GET /admin/verdicts/1/edit
  def edit
    set_date
  end

  # POST /admin/verdicts
  # POST /admin/verdicts.json
  def create
    @verdict = Verdict.new(verdict_params)

    respond_to do |format|
      if @verdict.save
        format.html { redirect_to admin_verdicts_path(v: @verdict.slug), notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.verdict', count: 1)) }
      else
        set_date
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/verdicts/1
  # PATCH/PUT /admin/verdicts/1.json
  def update
    respond_to do |format|
      if @verdict.update(verdict_params)
        format.html { redirect_to admin_verdicts_path(v: @verdict.slug), notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.verdict', count: 1)) }
      else
        set_date
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/verdicts/1
  # DELETE /admin/verdicts/1.json
  def destroy
    @verdict.destroy
    respond_to do |format|
      format.html { redirect_to admin_verdicts_url, notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.verdict', count: 1)) }
    end
  end


  def publish
    @verdict.is_public = true
    respond_to do |format|
      if @verdict.save
        format.html { redirect_to admin_verdicts_path(v: @verdict.slug), notice: t('shared.msgs.success_published',
                            obj: t('activerecord.models.verdict', count: 1)) }
      else
        format.html { redirect_to admin_verdicts_path(v: @verdict.slug), alert: t('shared.msgs.fail_published',
                            obj: t('activerecord.models.verdict', count: 1),
                            msg: @verdict.errors.full_messages.join('; ')) }
      end
    end
  end

  def unpublish
    @verdict.is_public = false
    respond_to do |format|
      if @verdict.save
        format.html { redirect_to admin_verdicts_path(v: @verdict.slug), notice: t('shared.msgs.success_unpublished',
                            obj: t('activerecord.models.verdict', count: 1)) }
      else
        format.html { redirect_to admin_verdicts_path(v: @verdict.slug), alert: t('shared.msgs.fail_unpublished',
                            obj: t('activerecord.models.verdict', count: 1),
                            msg: @verdict.errors.full_messages.join('; ')) }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_verdict
      @verdict = Verdict.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def verdict_params
      permitted = Verdict.globalize_attribute_names + [
        :time_period, :is_public, :report_en, :report_ka,
        :overall_score, :category1_score, :category2_score, :category3_score
      ]
      params.require(:verdict).permit(*permitted)
    end

    # set the date for the datepicker
    def set_date
      gon.time_period = @verdict.time_period.strftime('%m/%d/%Y %H:%M') if !@verdict.time_period.nil?
    end    
end
