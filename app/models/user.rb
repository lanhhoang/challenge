# frozen_string_literal: true

class User < ApplicationRecord

  validates :name, presence: true
  validates :email, presence: true

  has_and_belongs_to_many :companies

end
