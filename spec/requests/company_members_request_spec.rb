# frozen_string_literal: true

require "rails_helper"

RSpec.describe "CompanyMembers", type: :request do
  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # CompaniesController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) do
    {}
  end

  it "company doesn't exist" do
    get company_members_path(company_id: "xyz"), headers: valid_headers, as: :json
    expect(response).to be_not_found
  end

  describe "GET /index" do
    it "renders a successful response" do
      company = Company.new(name: "AB Corp.")
      %w[one two three].each do |name|
        company.users.build(name: name.capitalize, email: "#{name}@abc.com")
      end
      company.save!

      get company_members_path(company_id: company.id), headers: valid_headers, as: :json
      expect(response).to be_successful

      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(3)
      expect(json_response).to eq(company.users.as_json)
    end
  end

  describe "POST /create" do
    context "user exists" do
      it "adds user to company" do
        company = Company.create!(name: "AB Corp.")
        user = User.create!(name: "one", email: "one@abc.com")
        post company_members_path(company_id: company.id),
             params: { user_id: user.id }, headers: valid_headers, as: :json

        expect(response).to be_successful
        company.reload

        expect(company.users.count).to eq(1)
        expect(company.users.first.id).to eq(user.id)
      end
    end

    context "user not found" do
      it "company doesn't exist" do
        company = Company.create!(name: "AB Corp.")
        post company_members_path(company_id: company.id, params: { user_id: "xyz" }), headers: valid_headers, as: :json
        expect(response).to be_not_found
      end
    end
  end

  describe "DELETE /destroy" do
    it "removes the member from the company" do
      company = Company.create!(name: "AB Corp.")
      user = company.users.create!(name: "One", email: "one@abc.com")
      delete company_member_path(company_id: company.id, id: user.id), headers: valid_headers, as: :json
      expect(company.reload.users.count).to eq(0)
    end

    it "when user doesn't exist" do
      company = Company.create!(name: "AB Corp.")
      delete company_member_path(company_id: company.id, id: "xyz"), headers: valid_headers, as: :json
      expect(response).to be_not_found
    end
  end
end
