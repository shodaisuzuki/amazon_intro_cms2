class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_site, only: [:index, :show, :create, :new, :edit,:destroy]
  before_action :set_user, only: [:new,]
  before_action :site_owner?, except: [:show, :update]

  # GET /products
  # GET /products.json
  def index
    @products = @site.products.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @tags = @product.product_tags
    @products = @tags.map { |tag| tag.product if tag.product.id == @product.id }.take(4)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to site_path(@site), notice: '商品の作成に成功しました' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
      @site = Site.find(product_params[:site_id])
      @user = @site.user

      site_owner?
      respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to site_path(@site), notice: "商品#{@product.title}を編集しました" }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to site_path(@site), notice: '商品を削除しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def set_site
      @site = Site.find(params[:site_id])
    end

    def set_user
      @user = @site.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:site_id, :title, :introduction, :price, :image, :remove_image, :release_status, :amazon_id)
    end

    def site_owner?
      redirect_to site_path(@site) unless current_user == @site.user
    end

end
