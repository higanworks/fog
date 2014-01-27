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

      end

    end
  end
end
