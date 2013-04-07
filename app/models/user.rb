class User < ActiveRecord::Base
  attr_accessible :oauth_token, :dwolla_id
end
