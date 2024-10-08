json.extract! order, :id, :product_name, :product_count, :customer_id, :updated_at
json.url order_url(order, format: :json)