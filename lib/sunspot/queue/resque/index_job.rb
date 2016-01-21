require "sunspot/queue/helpers"

module Sunspot::Queue::Resque
  class IndexJob
    extend ::Sunspot::Queue::Helpers

    def self.queue
      :sunspot
    end

    def self.perform(klass, id)
      without_proxy do
        constantize(klass).unscoped.find(id).try(:solr_index)
      end
    end
  end
end
