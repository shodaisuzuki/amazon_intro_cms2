class SitesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :set_site, only: [:tag_search, :show, :edit, :update, :destroy]
  before_action :set_user

  def tag_search
    #TODO: tag_idに紐づくproductsを返す
    @products = @site.products.page(params[:page])
    @products_count = @site.products.all.count
    @tag = Tag.find(params[:tag_id])
    @tags = @site.tags.all
  end

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all
  end

  def show
    @products = @site.products.where(release_status: true).page(params[:page])
    @tags = @site.tags.all
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)
    respond_to do |format|
      if @site.save
        format.html { redirect_to user_path(@user), notice: 'サイトを作成しました' }
        format.json { render user_path(@user), status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to user_path(@user), notice: "サイト[#{@site.name}]を編集しました" }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: "サイト[#{@site.name}]を削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:user_id, :name, :caption, :release_status)
    end

    def set_user
      @user = current_user
    end
end
