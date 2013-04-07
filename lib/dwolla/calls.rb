module Dwolla
  module Calls
    require 'rest_client'

    def get_request(uri, params = {})
      log_call("GET REQUEST: #{DWOLLA_URL}/#{uri}#{query_string(params)}")
      resource = RestClient::Resource.new("#{DWOLLA_URL}/#{uri}#{query_string(params)}")
      response = resource.get{|res, req, result| res}
      log_call("GET RESPONSE: " + (response ? response : "No response received."))
      JSON.parse(response)
    rescue => e
      log_call("GET RESPONSE: Rescue block - something went wrong.")
      log_call("GET RESPONSE: " + e.message)
      error_hash
    end

    def post_request(uri, params = {})
      log_call("POST REQUEST: #{DWOLLA_URL}/#{uri}")
      resource = RestClient::Resource.new("#{DWOLLA_URL}/#{uri}")
      response = resource.post(params){|res, req, result| res}
      log_call("POST RESPONSE: " + (response ? response : "No response received."))
      JSON.parse(response)
    rescue => e
      log_call("POST RESPONSE: Rescue block - something went wrong.")
      log_call("POST RESPONSE: " + e.message)
      error_hash
    end

    def put_request(uri, params = {})
      log_call("PUT REQUEST: #{DWOLLA_URL}/#{uri}")
      resource = RestClient::Resource.new("#{DWOLLA_URL}/#{uri}")
      response = resource.put(params){|res, req, result| res}
      log_call("PUT RESPONSE: " + (response ? response : "No response received."))
      JSON.parse(response)
    rescue => e
      log_call("PUT RESPONSE: Rescue block - something went wrong.")
      log_call("PUT RESPONSE: " + e.message)
      error_hash
    end

    def delete_request(uri)
      log_call("DELETE REQUEST: #{DWOLLA_URL}/#{uri}")
      resource = RestClient::Resource.new("#{DWOLLA_URL}/#{uri}")
      response = resource.delete {|response, request, result| response }
      log_call("DELETE RESPONSE: " + (response ? response : "No response received."))
      JSON.parse(response)
    rescue => e
      log_call("DELETE RESPONSE: Rescue block - something went wrong.")
      log_call("DELETE RESPONSE: " + e.message)
      error_hash
    end

    def query_string(params)
      return "" unless params && params.is_a?(Hash) && params.keys.count > 0
      "?" + params.map{|k,v| "#{CGI.escape(k)}=#{CGI.escape(v)}"}.join("&")
    end

    def log_call(log_message)

      filename = Rails.root.join('log',"dwolla_log_#{Date.today.strftime("%Y%m%d")}.log")

      File.open(filename,'a+') do |file|
        file.puts(Time.now.strftime("%Y-%m-%d %H:%M:%S") + ": " + log_message)
        file.puts("")
      end
    end

    def error_hash
      {"error" => "UNKNOWN ERROR"}
    end
  end
end
