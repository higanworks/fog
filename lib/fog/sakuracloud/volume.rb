require 'fog/sakuracloud'
require 'fog/volume'

module Fog
  module Volume
    class SakuraCloud < Fog::Service

      requires     :sakuracloud_api_token
      requires     :sakuracloud_api_token_secret

      recognizes   :sakuracloud_api_url

      model_path 'fog/sakuracloud/models/volume'
      model      :archive
      collection :archives
      model      :plan
      collection :plans
      model      :disk
      collection :disks

      request_path 'fog/sakuracloud/requests/volume'
      request      :list_disks
      request      :list_plans
      request      :create_disk
      request      :configure_disk
      request      :attach_disk
      request      :delete_disk
      request      :list_archives

      class Real
        def initialize(options = {})
          @auth_encord = Base64.strict_encode64([
            options[:sakuracloud_api_token],
            options[:sakuracloud_api_token_secret]
          ].join(':'))

          @sakuracloud_api_url = options[:sakuracloud_api_url] || 'https://secure.sakura.ad.jp'

          @connection = Fog::Connection.new(@sakuracloud_api_url)
        end

        def request(params)
          response = parse @connection.request(params)
          response
        end

        private
        def parse(response)
          return response if response.body.empty?
          response.body = Fog::JSON.decode(response.body)
          response
        end
      end

      class Mock
        def initialize(options = {})
        end
      end

    end #SakuraCloud
  end #Volume
end
