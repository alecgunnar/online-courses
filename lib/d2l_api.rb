require 'openssl'
require 'Base64'

module D2lApi
  @@digest = 'sha256'

  def auth_url
    target_url = "#{Rails.configuration.d2l['target_url']}#{account_api_tokens_path}"
    url        = service_url '/d2l/auth/api/token'

    url << "x_target=" << CGI.escape(target_url)
    url << "&x_a=#{Rails.configuration.d2l['app_id']}"
    url << "&x_b=#{generate_auth_signature target_url}"
  end

  def get_current_courses
    url = service_url '/d2l/api/lp/(version)/enrollments/myenrollments'


  end

  private
    def service_url (path)
      "#{Rails.configuration.d2l['service_url']}:#{Rails.configuration.d2l['service_port']}#{path}?"
    end

    def generate_signature (key, data)
      Base64.encode64(OpenSSL::HMAC.digest(@@digest, key, data)).gsub('+', '-').gsub('/', '_').gsub('=', '')
    end

    def generate_app_signature (method, path, timestamp)
      generate_signature Rails.configuration.d2l['app_key'], "#{method.upcase}&#{path.downcase}&#{Time.new}"
    end

    def generate_auth_signature (url)
      generate_signature Rails.configuration.d2l['app_key'], url
    end
end
