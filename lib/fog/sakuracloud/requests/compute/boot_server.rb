# coding: utf-8

module Fog
  module Compute
    class SakuraCloud
      class Real

        def boot_server( id )
          request(
            :headers => {
              'Authorization' => "Basic #{@auth_encord}"
            },
            :expects  => [200],
            :method => 'PUT',
            :path => "#{Fog::SakuraCloud::SAKURACLOUD_API_ENDPOINT}/server/#{id}/power"
          )
        end
      end # Real
    end # SakuraCloud
  end # Volume
end # Fog
