require 'rails_helper'

RSpec.describe "CustomersControllers", type: :request do  

  describe "get customers_path" do
    it "renders the index view" do
      customer = FactoryBot.create(:customer)
      get "/customers", params: {customer: {first_name: "Bob"}}
      expect(response).to render_template(:index)
    end
  end

  
  describe "get customer_path" do
    it "renders the :show template" do
      customer = FactoryBot.create(:customer)
      get "/customers/#{customer.id}", params: {customer: {first_name: "Bob"}}
      expect(response).to render_template(:show)
    end
    it "redirects to the index path if the customer id is invalid" do
      get "/customers/#{500}", params: {customer: {first_name: "Bob"}} 
      expect(response).to redirect_to("/customers")
      end
  end

  describe "get new_customer_path" do
    it "renders the :new template" do
      customer = FactoryBot.create(:customer)
      get "/customers/new/", params: {customer: {first_name: "Bob"}}
      expect(response.status).to eq(200)
    end
  end
  
  describe "get edit_customer_path" do
    it "renders the :edit template" do
      customer = FactoryBot.create(:customer)
      get "/customers/#{customer.id}/edit", params: {customer: {first_name: "Bob"}}
      expect(response.status).to eq(200)
    end
  end
  
  describe "post customers_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      customer = FactoryBot.create(:customer)
      post "/customers", params: { customer: { first_name: "Jack", last_name: "Smith", phone: "8889995678", email: "jsmith@sample.com"}}
    end
  end
  
  describe "post customers_path with invalid data" do
    it "does not save a new entry or redirect" do
      customer = FactoryBot.create(:customer)
      post "/customers", params: { customer: {first_name: 9}}
      expect(customer.first_name).not_to eq(9)
      expect(response).to render_template(:new)
    end
  end
  
  describe "put customer_path with valid data" do
    it "updates an entry and redirects to the show path for the customer" do
      customer = FactoryBot.create(:customer)
      put "/customers/#{customer.id}", params: {customer: {first_name: "Bob"}}
      customer.reload
      expect(customer.first_name).to eq("Bob")
      expect(response).to redirect_to("/customers/#{customer.id}")
    end
  end
  
  describe "put customer_path with invalid data" do
    it "does not update the customer record or redirect" do
      customer = FactoryBot.create(:customer)
      put "/customers/#{customer.id}", params: {customer: {phone: 5001}}
      customer.reload
      expect(customer.id).not_to eq(5001)
      expect(response).to render_template(:edit)
    end
  end

  describe "delete a customer record" do
    it "deletes a customer record" do
      customer = FactoryBot.create(:customer)
      delete "/customers/#{customer.id}", params: {customer: {first_name: "Bob"}}
      expect(response.status).to eq(302)
    end
  end
end