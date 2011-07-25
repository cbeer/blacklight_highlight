module BlacklightHighlight
  module SolrDocumentExtension
    def self.included some_class
      some_class.after_initialize do
        solr_response.send(:extend, RSolr::Ext::Response::Highlight) unless solr_response.is_a? RSolr::Ext::Response::Highlight
      end
    end

    def [] key
      return highlight(key) unless highlight(key).blank?

      super(key)
    end

    def highlight key=nil
      solr_response.highlight(self, key) if solr_response and solr_response.respond_to? :highlight
    end
  end
end
