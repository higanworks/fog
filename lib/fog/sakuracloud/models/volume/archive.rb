require 'fog/core/model'

module Fog
  module Volume
    class SakuraCloud
      class Archive < Fog::Model

        identity :ID
        attribute :Name
        attribute :Plan

      end
    end
  end
end
