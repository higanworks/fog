require 'fog/core/model'

module Fog
  module Volume
    class SakuraCloud
      class Disk < Fog::Model

        identity :ID
        attribute :Name
        attribute :Connection
        attribute :Plan
        attribute :SizeMB
        attribute :SourceDisk
        attribute :SourceArchive

      end
    end
  end
end
