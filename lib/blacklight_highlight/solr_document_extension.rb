module BlacklightHighlight
  module SolrDocumentExtension
    def self.included some_class
      some_class.after_initialize do
        solr_response.send(:extend, RSolr::Ext::Response::Highlight) unless solr_response.is_a? RSolr::Ext::Response::Highlight
      end
    end

    def [] key
      return super(key) if key == self.class.unique_key
      return highlight(key) if highlight_fields.key?(key) and not highlight(key).blank?

      super(key)
    end

    def key? key
      return super(key) if key == self.class.unique_key
      return true if highlight_fields.key?(key)
    
      super(key)
    end

    def highlight key = nil
      return if key == self.class.unique_key
      highlight_fields[key].map { |x| x.html_safe }
    end

    def highlight_fields
      @highlight_fields ||= begin
        return {} unless solr_response and solr_response.respond_to? :highlight
        solr_response.highlight(self)
      end
    end
  end
end
