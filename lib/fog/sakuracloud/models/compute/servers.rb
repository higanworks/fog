require 'fog/core/collection'
require 'fog/sakuracloud/models/compute/server'

module Fog
  module Compute
    class SakuraCloud

      class Servers < Fog::Collection
        model Fog::Compute::SakuraCloud::Server

        def all
          load service.list_servers.body['Servers']
        end

        def get(id)
          all.find { |f| f.ID == id }
        rescue Fog::Errors::NotFound
          nil
        end

        def create_with(options = {})
          Fog::Logger.warning("Create Volume")
          volume = Fog::Volume::SakuraCloud.new(:sakuracloud_api_token => options[:sakuracloud_api_token], :sakuracloud_api_token_secret => options[:sakuracloud_api_token_secret])
          disk = volume.disks.create :Name => Fog::UUID.uuid,
                              :Plan  => options[:diskplan].to_i,
                              :SourceArchive => options[:sourcearchive].to_s
          Fog::Logger.warning("Waiting disk until available")
          disk.wait_for
          volume.configure_disk(disk.ID, options[:ssh_key])
          Fog::Logger.warning("Create Server")
          server = create :Name => Fog::UUID.uuid,
                          :ServerPlan =>  options[:serverplan]
          volume.attach_disk(disk.ID, server.ID)
          server.boot
        end
      end

    end
  end
end
