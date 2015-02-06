class NegativeExpression < ActiveRecord::Base
  scope :expressions_for, -> (host) {
    where("lower(?) ~* ANY(domains)", host)
  }
end
