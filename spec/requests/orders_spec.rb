require 'rails_helper'

RSpec.describe "OrdersControllers", type: :request do

  describe "get orders_path" do
    it "renders the index view" do 
     order = FactoryBot.create(:order)
     get "/orders", params: {order: {product_count: 10}}
     expect(response).to render_template(:index)
    end
  end
  
  describe "get orders_path" do
    it "renders the :show template" do
      order = FactoryBot.create(:order)
      get "/orders/#{order.id}", params: {order: {product_count: 123}}
      expect(response).to render_template(:show)
    end
    it "redirects to the index path if the order id is invalid" do 
      get "/orders/#{500}", params: {order: {product_count: 123}}
      expect(response).to redirect_to("/orders")
    end
  end

  describe "get new_order_path" do 
    it "renders the :new template" do
      order = FactoryBot.create(:order)
      get "/orders/new/", params: {order: {product_count: 10}}
      expect(response.status).to eq(200)
    end
  end

  describe "get edit_order_path" do
    it "renders the :edit template" do 
      order = FactoryBot.create(:order)
      get "/orders/#{order.id}/edit/", params: {order: {product_count: 10}}
    end
  end

  describe "post orders_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      order = FactoryBot.create(:order)
      post "/orders", params: { order: { product_name: "gears", product_count: 7, customer_id: 1 } }
    end
  end


 describe "post orders_path with invalid data" do
  it "does not save a new entry or redirect" do
    order = FactoryBot.create(:order)
    post "/orders", params: {order: {product_name: 10}}
    expect(order.product_name).not_to eq(10)
    expect(response).to render_template(:new)
  end
end


  describe "put order_path with valid data" do
    it "updates an entry and redirects to the show path for the customer" do
      order = FactoryBot.create(:order)
      put "/orders/#{order.id}", params: {order: {product_count: 50}}
      order.reload
      expect(order.product_count).to eq(50)
      expect(response).to redirect_to("/orders/#{order.id}")
    end
  end

  describe "put order_path with invalid data" do
    it "does not update the customer record or redirect" do
      order = FactoryBot.create(:order)
      put "/orders/#{order.id}", params: {order: {customer_id: 5001}}
      order.reload
      expect(order.customer_id).not_to eq(5001)
      expect(response).to render_template(:edit)
    end
  end

  describe "delete a order record" do
    it "deletes a order record" do
      order = FactoryBot.create(:order)
      delete "/orders/#{order.id}", params: {order: {product_count: 123}}
      expect(response.status).to eq(302)
    end
  end
end