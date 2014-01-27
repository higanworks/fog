# coding: utf-8

module Fog
  module Compute
    class SakuraCloud
      class Real
        def list_zones(options = {})
          request(
            :headers => {
              'Authorization' => "Basic #{@auth_encord}"
            },
            :method => 'GET',
            :path => "#{Fog::SakuraCloud::SAKURACLOUD_API_ENDPOINT}/zone"
          )
        end
      end

      class Mock
        def list_zones(options = {})
          response = Excon::Response.new
          response.status = 200
          response.body = {
          }
        end
      end
    end
  end
end
