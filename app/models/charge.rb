class Charge < ActiveRecord::Base
    belongs_to :studio
    belongs_to :event
    has_many :purchases, foreign_key: "product_id"
    has_many :customers, :through => :purchase

  attr_accessible :studio_id, :user_id, :amount, :stripe_card_token, :description, :email
end
