module Dwolla
  module Calls
    require 'rest_client'

    def get_request(uri, params = {})
      if params[:page].present?
        resource = make_request(uri, "#{params[:query]}&page=#{params[:page]}")
      else
        resource = make_request(uri, "#{params[:query]}")
      end
      response = resource.get{|res, req, result| res}
      log_call("GET RESPONSE: " + (response ? response : "No response received."))
      JSON.parse(response)
    rescue => e
      log_call("GET RESPONSE: Rescue block - something went wrong.")
      log_call("GET RESPONSE: " + e.message)
      error_hash
    end

    def make_request(uri, query_string)
      log_call("GET REQUEST: #{API_BASE_URL}/#{uri}.json/?#{query_string}")
      RestClient::Resource.new("#{API_BASE_URL}/#{uri}.json/?#{query_string}")
    end

    def post_request(uri, params = {})
      log_call("POST REQUEST: #{API_BASE_URL}/#{uri}.json")
      resource = RestClient::Resource.new("#{API_BASE_URL}/#{uri}.json", timeout: 120, open_timeout: 120)
      response = resource.post(params){|res, req, result| res}
      log_call("POST RESPONSE: " + (response ? response : "No response received."))
      JSON.parse(response)
    rescue => e
      log_call("POST RESPONSE: Rescue block - something went wrong.")
      log_call("POST RESPONSE: " + e.message)
      error_hash
    end

    def put_request(uri, params = {})
      log_call("PUT REQUEST: #{API_BASE_URL}/#{uri}.json")
      resource = RestClient::Resource.new("#{API_BASE_URL}/#{uri}.json", timeout: 420, open_timeout: 420)
      response = resource.put(params){|res, req, result| res}
      log_call("PUT RESPONSE: " + (response ? response : "No response received."))
      JSON.parse(response)
    rescue => e
      log_call("PUT RESPONSE: Rescue block - something went wrong.")
      log_call("PUT RESPONSE: " + e.message)
      error_hash
    end

    def delete_request(uri, id)
      log_call("DELETE REQUEST: #{API_BASE_URL}/#{uri}/#{id}.json")
      resource = RestClient::Resource.new("#{API_BASE_URL}/#{uri}/#{id}.json")
      response = resource.delete {|response, request, result| response }
      log_call("DELETE RESPONSE: " + (response ? response : "No response received."))
      JSON.parse(response)
    rescue => e
      log_call("DELETE RESPONSE: Rescue block - something went wrong.")
      log_call("DELETE RESPONSE: " + e.message)
      error_hash
    end

    private

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
