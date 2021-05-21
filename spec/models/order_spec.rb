require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { Order.new( product_name: "gears", product_count: 7, customer: FactoryBot.create(:customer))}
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without product_count" do
    subject.product_count=nil
    expect(subject).to_not be_valid
  end

  it "is not valid without product_name" do
    subject.product_name=nil
    expect(subject).to_not be_valid

  end

  it "is not valid if the product count is not all digits" do
    subject.product_count="abc"
    expect(subject).to_not be_valid
  end

  it "is not valid without customer_id" do
    subject.customer_id=nil
    expect(subject).to_not be_valid
  end

  it "is not valid with an invalid customer_id" do
    subject.customer_id=5555
    expect(subject).to_not be_valid
  end
end
