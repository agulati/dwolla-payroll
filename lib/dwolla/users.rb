module Dwolla
  class Users
    include Dwolla::Calls

    attr_reader :user_id

    def initialize(user_id)
      @user = {}
      @module_path = "rest/users/"
    end

    def get_account_information
    end

    def get_basic_information
    end

    def get_nearby
    end
  end
end