class Admin::ExternalIndicatorsController < ApplicationController
  before_action :set_external_indicator, only: [:show, :edit, :update, :destroy, :data]
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
    gon.chart_download = highchart_export_config
    gon.change_icons = view_context.change_icons

    @chart_data = @external_indicator.format_for_charting
    gon.charts = [@chart_data]
  end

  # GET /admin/external_indicators/new
  def new
    @external_indicator = ExternalIndicator.new
    @external_indicator.countries.build
    @external_indicator.indices.build
    @external_indicator.plot_bands.build
  end

  # GET /admin/external_indicators/1/edit
  def edit
    @external_indicator.countries.build if @external_indicator.countries.length == 0
    @external_indicator.indices.build if @external_indicator.indices.length == 0
    @external_indicator.plot_bands.build if @external_indicator.plot_bands.length == 0
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


  def data
    if request.patch?
      @external_indicator.update_change_values = true
      if @external_indicator.update(external_indicator_params)
        flash[:notice] = t('shared.msgs.success_updated',
                            obj: t('activerecord.models.external_indicator', count: 1))
      end
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
      @reforms = Reform.active.sorted

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
      permitted = ExternalIndicator.globalize_attribute_names + [
        :is_public, :use_decimals, :show_on_home_page, :indicator_type, :scale_type, :chart_type,
        :min, :max, :sort_order, :has_benchmark, reform_ids: [],
        indices_attributes: [ExternalIndicatorIndex.globalize_attribute_names + [:id, :_destroy, :change_multiplier, :sort_order, :external_indicator_id]],
        countries_attributes: [ExternalIndicatorCountry.globalize_attribute_names + [:id, :_destroy, :sort_order, :external_indicator_id]],
        plot_bands_attributes: [ExternalIndicatorPlotBand.globalize_attribute_names + [:id, :_destroy, :to, :from, :external_indicator_id]],
        time_periods_attributes: [ExternalIndicatorTime.globalize_attribute_names + [:id, :_destroy, :sort_order, :overall_value, :external_indicator_id],
        data_attributes: [:id, :_destroy, :value, :country_id, :index_id, :external_indicator_time_id, :is_benchmark]]
      ]
      params.require(:external_indicator).permit(*permitted)
    end
end
