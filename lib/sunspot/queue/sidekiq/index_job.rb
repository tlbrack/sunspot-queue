require "sidekiq/worker"

module Sunspot::Queue::Sidekiq
  class IndexJob
    include ::Sunspot::Queue::Helpers
    include ::Sidekiq::Worker

    sidekiq_options :queue => "sunspot"

    def perform(klass, id)
      without_proxy do
        constantize(klass).unscoped.find_by_id(id).try(:solr_index)
      end
    end
  end
end
