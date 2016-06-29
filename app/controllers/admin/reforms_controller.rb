class Admin::ReformsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reform, only: [:show, :edit, :update, :destroy]
  before_action :load_colors, only: [:new, :edit, :create, :update]
  authorize_resource

  # GET /admin/reforms
  # GET /admin/reforms.json
  def index
    @reforms = Reform.with_color#.sorted
  end

  # GET /admin/reforms/1
  # GET /admin/reforms/1.json
  def show
  end

  # GET /admin/reforms/new
  def new
    @reform = Reform.new
  end

  # GET /admin/reforms/1/edit
  def edit
  end

  # POST /admin/reforms
  # POST /admin/reforms.json
  def create
    @reform = Reform.new(reform_params)

    respond_to do |format|
      if @reform.save
        format.html { redirect_to admin_reforms_path, notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.reform', count: 1)) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/reforms/1
  # PATCH/PUT /admin/reforms/1.json
  def update
    respond_to do |format|
      if @reform.update(reform_params)
        format.html { redirect_to admin_reforms_path, notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.reform', count: 1)) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/reforms/1
  # DELETE /admin/reforms/1.json
  def destroy
    @reform.destroy
    respond_to do |format|
      format.html { redirect_to admin_reforms_url, notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.reform', count: 1)) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reform
      @reform = Reform.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reform_params
      permitted = Reform.globalize_attribute_names + [:is_active, :is_highlight, :reform_color_id]
      params.require(:reform).permit(*permitted)
    end

    # load the reform colors
    def load_colors
      @colors = ReformColor.all
    end
end
