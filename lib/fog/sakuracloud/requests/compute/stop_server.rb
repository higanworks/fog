# coding: utf-8

module Fog
  module Compute
    class SakuraCloud
      class Real

        def stop_server( id, force = false )
          if force
            body = { "Force" => true }
          else
            body = {}
          end
          request(
            :headers => {
              'Authorization' => "Basic #{@auth_encord}"
            },
            :expects  => [200,202],
            :method => 'DELETE',
            :path => "#{Fog::SakuraCloud::SAKURACLOUD_API_ENDPOINT}/server/#{id}/power",
            :body => Fog::JSON.encode(body),
          )
        end
      end # Real
    end # SakuraCloud
  end # Volume
end # Fog
