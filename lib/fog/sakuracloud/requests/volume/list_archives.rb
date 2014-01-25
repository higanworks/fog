# coding: utf-8

module Fog
  module Volume
    class SakuraCloud
      class Real
        def list_archives(options = {})
          request(
            :headers => {
              'Authorization' => "Basic #{@auth_encord}"
            },
            :method => 'GET',
            :path => "#{Fog::SakuraCloud::SAKURACLOUD_API_ENDPOINT}/archive"
          )
        end
      end

      class Mock
        def list_archives(options = {})
          response = Excon::Response.new
          response.status = 200
          response.body = {
          }
        end
      end
    end
  end
end
