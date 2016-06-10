class Admin::ReformColorsController < ApplicationController
  before_action :set_reform_color, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /admin/reform_colors
  # GET /admin/reform_colors.json
  def index
    @reform_colors = ReformColor.all.with_reforms
  end

  # GET /admin/reform_colors/1
  # GET /admin/reform_colors/1.json
  def show
  end

  # GET /admin/reform_colors/new
  def new
    @reform_color = ReformColor.new
  end

  # GET /admin/reform_colors/1/edit
  def edit
  end

  # POST /admin/reform_colors
  # POST /admin/reform_colors.json
  def create
    @reform_color = ReformColor.new(reform_color_params)

    respond_to do |format|
      if @reform_color.save
        format.html { redirect_to admin_reform_colors_path, notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.reform_color', count: 1)) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/reform_colors/1
  # PATCH/PUT /admin/reform_colors/1.json
  def update
    respond_to do |format|
      if @reform_color.update(reform_color_params)
        format.html { redirect_to admin_reform_colors_path, notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.reform_color', count: 1)) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/reform_colors/1
  # DELETE /admin/reform_colors/1.json
  def destroy
    @reform_color.destroy
    respond_to do |format|
      format.html { redirect_to admin_reform_colors_url, notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.reform_color', count: 1)) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reform_color
      @reform_color = ReformColor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reform_color_params
      params.require(:reform_color).permit(:hex, :r, :g, :b)
    end
end
