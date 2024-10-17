# frozen_string_literal: true

require "rails_helper"

RSpec.describe Company, type: :model do
  it "name is required" do
    company = described_class.new
    expect(company).to be_invalid
    expect(company.errors[:name]).to include("can't be blank")
  end

  it "has many users" do
    company = described_class.new name: "ABC Corp."
    company.users.build name: "Anyone", email: "anyone@abc.corp"
    company.save!
    expect(company.users.pluck(:email)).to include("anyone@abc.corp")
  end
end
