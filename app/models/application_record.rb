class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Deal with #first and #last when using uuids as primary keys
  # More info: https://pawelurbanek.com/uuid-order-rails
  self.implicit_order_column = "created_at"
end
