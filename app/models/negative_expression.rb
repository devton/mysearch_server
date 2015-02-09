class NegativeExpression < ActiveRecord::Base
  scope :expressions_for, -> (host) {
    where("lower(?) ~* ANY(domains)", host)
  }

  scope :with_path_regex, ->(path) {
    where("lower(?) ~* ANY(expressions)", path)
  }

  def self.url_match? url
    uri = URI url
    expressions_for(uri.host).with_path_regex(uri.path).exists?
  end
end
