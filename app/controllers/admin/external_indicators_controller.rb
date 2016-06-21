class Admin::ExternalIndicatorsController < ApplicationController
  before_action :set_external_indicator, only: [:show, :edit, :update, :destroy]
  before_action :set_type_arrays, only: [:new, :edit, :create, :update]
  authorize_resource

  # GET /admin/external_indicators
  # GET /admin/external_indicators.json
  def index
    @external_indicators = ExternalIndicator.sorted
  end

  # GET /admin/external_indicators/1
  # GET /admin/external_indicators/1.json
  def show
  end

  # GET /admin/external_indicators/new
  def new
    @external_indicator = ExternalIndicator.new
  end

  # GET /admin/external_indicators/1/edit
  def edit
  end

  # POST /admin/external_indicators
  # POST /admin/external_indicators.json
  def create
    @external_indicator = ExternalIndicator.new(external_indicator_params)

    respond_to do |format|
      if @external_indicator.save
        format.html { redirect_to [:admin, @external_indicator], notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.external_indicator', count: 1)) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/external_indicators/1
  # PATCH/PUT /admin/external_indicators/1.json
  def update
    respond_to do |format|
      if @external_indicator.update(external_indicator_params)
        format.html { redirect_to [:admin, @external_indicator], notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.external_indicator', count: 1)) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/external_indicators/1
  # DELETE /admin/external_indicators/1.json
  def destroy
    @external_indicator.destroy
    respond_to do |format|
      format.html { redirect_to admin_external_indicators_url, notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.external_indicator', count: 1)) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_external_indicator
      @external_indicator = ExternalIndicator.find(params[:id])
    end

    # create array of indicator, chart and scale types
    def set_type_arrays
      @indicator_types = []
      @chart_types = []
      @scale_types = []
      ext_ind = ExternalIndicator

      ext_ind::INDICATOR_TYPES.keys.each do |key|
        @indicator_types << [I18n.t("shared.external_indicators.indicator_types.#{key}"), ext_ind::INDICATOR_TYPES[key]]
      end

      ext_ind::CHART_TYPES.keys.each do |key|
        @chart_types << [I18n.t("shared.external_indicators.chart_types.#{key}"), ext_ind::CHART_TYPES[key]]
      end

      ext_ind::SCALE_TYPES.keys.each do |key|
        @scale_types << [I18n.t("shared.external_indicators.scale_types.#{key}"), ext_ind::SCALE_TYPES[key]]
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def external_indicator_params
      permitted = ExternalIndicator.globalize_attribute_names + [:is_public, :show_on_home_page, :indicator_type, :scale_type, :chart_type, :min, :max]
      params.require(:external_indicator).permit(*permitted)
    end
end
