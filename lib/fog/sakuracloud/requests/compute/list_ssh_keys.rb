# coding: utf-8

module Fog
  module Compute
    class SakuraCloud
      class Real
        def list_ssh_keys(options = {})
          request(
            :headers => {
              'Authorization' => "Basic #{@auth_encord}"
            },
            :method => 'GET',
            :path => "#{Fog::SakuraCloud::SAKURACLOUD_API_ENDPOINT}/sshkey"
          )
        end
      end

      class Mock
        def list_disks(options = {})
          response = Excon::Response.new
          response.status = 200
          response.body = {
           "SSHKeys"=>
            [
            {"Index"=>0,
              "ID"=>"888888888888",
              "Description"=>"",
              "PublicKey"=>"ssh-rsa dummy",
              "CreatedAt"=>"2014-01-21T12:44:39+09:00"},
            {"Index"=>1,
              "ID"=>"999999999999",
              "Description"=>"",
              "PublicKey"=>"ssh-rsa dummy",
              "CreatedAt"=>"2014-01-21T12:44:39+09:00"}
              ],
           "is_ok"=>true
          }
          response
        end
      end
    end
  end
end
