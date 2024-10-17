# frozen_string_literal: true

require "rails_helper"

RSpec.describe Project, type: :model do
  it "name and start_date are required" do
    project = described_class.new
    expect(project).to be_invalid
    expect(project.errors[:name]).to include("can't be blank")
    expect(project.errors[:start_date]).to include("can't be blank")
  end
end
