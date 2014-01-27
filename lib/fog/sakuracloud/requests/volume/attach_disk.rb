# coding: utf-8

module Fog
  module Volume
    class SakuraCloud
      class Real

        def attach_disk( disk_id, server_id )

          request(
            :headers => {
              'Authorization' => "Basic #{@auth_encord}"
            },
            :expects  => [200],
            :method => 'PUT',
            :path => "#{Fog::SakuraCloud::SAKURACLOUD_API_ENDPOINT}/disk/#{disk_id.to_s}/to/server/#{server_id.to_s}"
          )
        end
      end # Real
    end # SakuraCloud
  end # Volume
end # Fog
