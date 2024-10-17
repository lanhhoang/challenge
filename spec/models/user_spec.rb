# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it "name and email are required" do
    user = described_class.new
    expect(user).to be_invalid
    expect(user.errors[:name]).to include("can't be blank")
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "has many companies" do
    user = described_class.new name: "Test", email: "tester@example.com"
    user.companies.build name: "ABC Inc."
    user.save!
    expect(user.companies.pluck(:name)).to include("ABC Inc.")
  end
end
