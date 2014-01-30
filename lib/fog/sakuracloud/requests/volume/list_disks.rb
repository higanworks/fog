# coding: utf-8

module Fog
  module Volume
    class SakuraCloud
      class Real
        def list_disks(options = {})
          request(
            :headers => {
              'Authorization' => "Basic #{@auth_encord}"
            },
            :method => 'GET',
            :path => "#{Fog::SakuraCloud::SAKURACLOUD_API_ENDPOINT}/disk"
          )
        end
      end

      class Mock
        def list_disks(options = {})
          response = Excon::Response.new
          response.status = 200
          response.body = {
          "Disks" => []
          }
          response
        end
      end
    end
  end
end
