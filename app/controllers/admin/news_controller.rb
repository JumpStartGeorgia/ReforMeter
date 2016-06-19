class Admin::NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  before_action :get_quarter
  before_action :load_reforms, only: [:new, :edit, :create, :update]

  # GET /admin/quarters/news
  # GET /admin/quarters/news.json
  def index
    @news = News.all
  end

  # GET /admin/quarters/news/1
  # GET /admin/quarters/news/1.json
  def show
  end

  # GET /admin/quarters/news/new
  def new
    @news = News.new
    @news.reform_id = params[:reform_id] if params[:reform_id].present?
  end

  # GET /admin/quarters/news/1/edit
  def edit
  end

  # POST /admin/quarters/news
  # POST /admin/quarters/news.json
  def create
    @news = News.new(news_params)

    respond_to do |format|
      if @news.save
        format.html { redirect_to admin_quarters_path(q: @quarter.slug), notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.news', count: 1)) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/quarters/news/1
  # PATCH/PUT /admin/quarters/news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to admin_quarters_path(q: @quarter.slug), notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.news', count: 1)) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/quarters/news/1
  # DELETE /admin/quarters/news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to admin_quarters_url(q: @quarter.slug), notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.news', count: 1)) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      permitted = News.globalize_attribute_names + [:quarter_id, :reform_id, :image]
      params.require(:news).permit(*permitted)
    end

    # get the quarter that this news items is for
    def get_quarter
      begin
        @quarter = Quarter.friendly.find(params[:quarter_id])

        if @quarter.nil?
          redirect_to admin_quarters_path,
                  alert: t('shared.msgs.does_not_exist')
        end
      rescue ActiveRecord::RecordNotFound  => e
        redirect_to admin_quarters_path,
                  alert: t('shared.msgs.does_not_exist')
      end
    end

    def load_reforms
      @reforms = Reform.active#.sorted
    end
end
