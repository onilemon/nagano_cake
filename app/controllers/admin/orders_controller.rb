class Admin::OrdersController < ApplicationController
   has_many :order_details, dependent: :destroy
   belongs_to :customer
end
s