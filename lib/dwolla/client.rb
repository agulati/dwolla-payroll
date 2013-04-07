module Dwolla
  class Client
    extend Dwolla::Calls

    def self.oauth_authentication_url(protocol, host_with_port)

      auth_params = {
        'scope' => 'send|transactions|balance|request|contacts|accountInfoFull|funding',
        'client_id' => DWOLLA_KEY,
        'response_type' => 'code',
        'redirect_uri' => "#{protocol}#{host_with_port}/dwolla_oauth_callback"
      }

      "#{DWOLLA_URL}v2/authenticate" + query_string(auth_params)
    end

    def self.get_token(code)

      token_params = {
        'client_id' => DWOLLA_KEY,
        'client_secret' => DWOLLA_SECRET,
        'grant_type' => 'authorization_code',
        'code' => code
      }

      token_response = get_request("v2/token", token_params)
      token = token_response && token_response['access_token'] ? token_response['access_token'] : 'ERROR'
      Rails.logger.debug("TOKEN = " + token )
    end
  end
end