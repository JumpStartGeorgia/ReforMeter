class Admin::QuartersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quarter, only: [:show, :edit, :update, :destroy, :publish, :unpublish]
  authorize_resource

  # GET /admin/quarters
  # GET /admin/quarters.json
  def index
    @quarters = Quarter.recent.all_quarters_array
    params[:q] = nil if !@quarters.map{|x| x[1]}.include?(params[:q])
    params[:q] = @quarters[0][1] if params[:q].nil? && @quarters.present?
    @quarter = Quarter.with_expert_survey.with_reform_surveys.with_news.friendly.find(params[:q]) if params[:q].present?
  end

  # GET /admin/quarters/1
  # GET /admin/quarters/1.json
  def show
  end

  # GET /admin/quarters/new
  def new
    @quarter = Quarter.new
  end

  # GET /admin/quarters/1/edit
  def edit
  end

  # POST /admin/quarters
  # POST /admin/quarters.json
  def create
    @quarter = Quarter.new(quarter_params)

    respond_to do |format|
      if @quarter.save
        format.html { redirect_to admin_quarters_path(q: @quarter.slug), notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.quarter', count: 1)) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/quarters/1
  # PATCH/PUT /admin/quarters/1.json
  def update
    respond_to do |format|
      if @quarter.update(quarter_params)
        format.html { redirect_to admin_quarters_path(q: @quarter.slug), notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.quarter', count: 1)) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/quarters/1
  # DELETE /admin/quarters/1.json
  def destroy
    @quarter.destroy
    respond_to do |format|
      format.html { redirect_to admin_quarters_url, notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.quarter', count: 1)) }
    end
  end


  def publish
    @quarter.is_public = true
    respond_to do |format|
      if @quarter.save
        format.html { redirect_to admin_quarters_path, notice: t('shared.msgs.success_published',
                            obj: t('activerecord.models.quarter', count: 1)) }
      else
        format.html { redirect_to admin_quarters_path, alert: t('shared.msgs.fail_published',
                            obj: t('activerecord.models.quarter', count: 1),
                            msg: @quarter.errors.full_messages.join('; ')) }
      end
    end
  end

  def unpublish
    @quarter.is_public = false
    respond_to do |format|
      if @quarter.save
        format.html { redirect_to admin_quarters_path, notice: t('shared.msgs.success_unpublished',
                            obj: t('activerecord.models.quarter', count: 1)) }
      else
        format.html { redirect_to admin_quarters_path, alert: t('shared.msgs.fail_unpublished',
                            obj: t('activerecord.models.quarter', count: 1),
                            msg: @quarter.errors.full_messages.join('; ')) }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quarter
      @quarter = Quarter.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quarter_params
      permitted = Quarter.globalize_attribute_names + [:quarter, :year, :is_public, :report]
      params.require(:quarter).permit(*permitted)
    end
end
