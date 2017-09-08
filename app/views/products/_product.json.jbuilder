json.extract! product, :id, :site_id, :title, :introduction, :price, :image, :release_status, :created_at, :updated_at
json.url product_url(product, format: :json)
