class Charge < ActiveRecord::Base
  attr_accessible :studio_id, :user_id, :amount, :stripe_card_token, :description, :email
end
