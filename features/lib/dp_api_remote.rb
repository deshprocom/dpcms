require 'faraday'
require 'json'
class DpApiRemote
  attr_accessor :conn, :response

  def initialize
    self.conn = Faraday.new(url: remote_path) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def get(uri, params = {})
    self.response = conn.get do |req|
      req.url "/v10/#{uri}", params
      req.options.timeout = 10
      req.headers['X-DP-APP-KEY'] = '467109f4b44be6398c17f6c058dfa7ee'
      req.headers['X_DP_CLIENT_IP'] = '127.0.0.1:8900'
    end
    self
  end

  def parsed_body
    JSON.parse self.response.body
  end

  def self.get(uri, params = {})
    self.new.get(uri, params)
  end

  private

  def remote_path
    raise '必须配置 DPAPI_SIT_PATH 的环境变量'  if ENV['DPAPI_SIT_PATH'].blank?
    ENV['DPAPI_SIT_PATH'].dup
  end
end