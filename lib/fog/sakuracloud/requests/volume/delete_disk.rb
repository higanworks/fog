# coding: utf-8

module Fog
  module Volume
    class SakuraCloud
      class Real

        def delete_disk( id )
          request(
            :headers => {
              'Authorization' => "Basic #{@auth_encord}"
            },
            :expects  => [200],
            :method => 'DELETE',
            :path => "#{Fog::SakuraCloud::SAKURACLOUD_API_ENDPOINT}/disk/#{id}"
          )
        end
      end # Real
    end # SakuraCloud
  end # Volume
end # Fog
