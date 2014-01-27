# coding: utf-8

module Fog
  module Compute
    class SakuraCloud
      class Real
        def list_plans(options = {})
          request(
            :headers => {
              'Authorization' => "Basic #{@auth_encord}"
            },
            :method => 'GET',
            :path => "#{Fog::SakuraCloud::SAKURACLOUD_API_ENDPOINT}/product/server"
          )
        end
      end

      class Mock
      end
    end
  end
end
