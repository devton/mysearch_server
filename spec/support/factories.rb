FactoryGirl.define do
  factory :crawled_url do
    url_scheme 'http'
    host 'www.foo.com'
    path '/'
  end
end
