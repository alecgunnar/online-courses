require 'openssl'
require 'base64'
require 'json'

module D2lApi
  @@digest       = 'sha256'
  @@lp_base_path = "/d2l/api/lp/#{Rails.configuration.d2l['api_version']}/"

  # Generates the URL necessary for initial user
  # authentication with ELearning
  def auth_url
    target_url = "#{Rails.configuration.d2l['target_url']}#{account_api_tokens_path}"
    url        = service_url '/d2l/auth/api/token'

    url << "x_target=" << CGI.escape(target_url)
    url << "&x_a=#{Rails.configuration.d2l['app_id']}"
    url << "&x_b=#{generate_auth_signature target_url}"
  end

  # Gets basic user data from ELearning
  def get_user (user)
    perform_api_request :get, "#{@@lp_base_path}users/whoami", user
  end

  def get_enrolled_courses (user)
    perform_api_request :get, "#{@@lp_base_path}enrollments/myenrollments", user
  end

  private
    # Generates the full url with port, path, host, all that stuff
    def service_url (path)
      "#{Rails.configuration.d2l['service_url']}:#{Rails.configuration.d2l['service_port']}#{path}?"
    end

    # Generates the full url (as above) with the API auth. credentials
    def service_url_with_credentials (method, path, user)
      url = service_url path

      timestamp = Time.new.to_i.to_s

      url << "x_a=#{Rails.configuration.d2l['app_id']}"
      url << "&x_b=#{user.token_id}"
      url << "&x_c=#{generate_app_signature method, path, timestamp}"
      url << "&x_d=#{generate_user_signature user, method, path, timestamp}"
      url << "&x_t=#{timestamp}"
    end

    # Generates an auth. signature
    def generate_signature (key, data)
      Base64.encode64(OpenSSL::HMAC.digest(@@digest, key, data)).gsub('+', '-').gsub('/', '_').gsub('=', '').strip
    end

    # Gets a signature for the app.
    def generate_app_signature (method, path, timestamp)
      generate_signature Rails.configuration.d2l['app_key'], "#{method.upcase}&#{path.downcase}&#{timestamp}"
    end

    # Gets a signature for the provided user context
    def generate_user_signature (user, method, path, timestamp)
      generate_signature user.token_key, "#{method.upcase}&#{path.downcase}&#{timestamp}"
    end

    # Gets a signature for initial authentication
    def generate_auth_signature (url)
      generate_signature Rails.configuration.d2l['app_key'], url
    end

    # Performs an API request
    def perform_api_request (method, path, user)
      #return service_url_with_credentials(method, path, user)

      req = Curl::Easy.new service_url_with_credentials(method, path, user)

      if Rails.configuration.d2l['disable_ssl_verification'] 
        req.ssl_verify_peer = false
      end

      case method.downcase
        when :get
          req.http_get
        when :post
          req.http_post
        when :delete
          req.http_delete
      end
      return req.body_str

      return false unless req.perform

      unless req.response_code == 200
        user.nil_token_values
        return false
      end

      JSON.parse req.body_str
    end
end
