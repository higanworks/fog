# coding: utf-8

module Fog
  module Compute
    class SakuraCloud
      class Real

        def create_server( name, serverplan )
          body = {
            "Server" => {
              "Name" => name,
              "ServerPlan" => {
                "ID" => serverplan.to_i
              },
              "ConnectedSwitches"=>[{"Scope"=>"shared", "BandWidthMbps"=>100}]
            }
          }



          request(
            :headers => {
              'Authorization' => "Basic #{@auth_encord}"
            },
            :expects  => [201],
            :method => 'POST',
            :path => "#{Fog::SakuraCloud::SAKURACLOUD_API_ENDPOINT}/server",
            :body => Fog::JSON.encode(body),
          )
        end
      end # Real
    end # SakuraCloud
  end # Volume
end # Fog
