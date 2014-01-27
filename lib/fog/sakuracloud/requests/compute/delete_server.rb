# coding: utf-8

module Fog
  module Compute
    class SakuraCloud
      class Real

        def delete_server( id, force = false, disks = [] )
          body = { "Force" => force, 'WithDisk' => disks }

          request(
            :headers => {
              'Authorization' => "Basic #{@auth_encord}"
            },
            :expects  => [200],
            :method => 'DELETE',
            :path => "#{Fog::SakuraCloud::SAKURACLOUD_API_ENDPOINT}/server/#{id}",
            :body => Fog::JSON.encode(body),
          )
        end
      end # Real
    end # SakuraCloud
  end # Volume
end # Fog
