# coding: utf-8

module Fog
  module Compute
    class SakuraCloud
      class Real
        def list_servers(options = {})
          request(
            :headers => {
              'Authorization' => "Basic #{@auth_encord}"
            },
            :method => 'GET',
            :path => "#{Fog::SakuraCloud::SAKURACLOUD_API_ENDPOINT}/server"
          )
        end
      end

      class Mock
        def list_servers(options = {})
          response = Excon::Response.new
          response.status = 200
          response.body = {
          "Servers" => []
          }
          response
        end
      end
    end
  end
end
