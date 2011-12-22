module BlacklightHighlight
  module SolrDocumentExtension
    extend ActiveSupport::Concern

    included do 
      after_initialize do
        solr_response.send(:extend, RSolr::Ext::Response::Highlight) unless solr_response.is_a? RSolr::Ext::Response::Highlight
      end
    end

    module ClassMethods
      ##
      # Provide a class-level method to white-list highlighted fields
      # By default, it will highlight every field for which there's a highlight result
      def highlight
        @highlight ||= []
      end
    end

    ## 
    # Override RSolr::Doc methods with highlighting equivalents
    def [] key
      return highlight(key) if highlight?(key)
      super(key)
    end

    ## 
    # Override RSolr::Doc methods with highlighting equivalents
    def key? key
      return true if highlight?(key)
      super(key)
    end

    ##
    # Get the (html-safe) highlight values for a field
    # @param [String] key
    def highlight key
      return unless highlight? key
      highlight_fields[key].map { |x| x.html_safe }
    end
    
    ##
    # Does the field have highlighting values?
    # @param [String] key
    def highlight? key
      return false if key.nil? or key == self.class.unique_key

      if self.class.highlight.include? key.to_sym
        return true
      elsif !self.class.highlight.empty?
        return false
      end

     !highlight_fields[key].blank?
    end

    def highlight_fields
      @highlight_fields ||= begin
        return {} unless solr_response and solr_response.respond_to? :highlight
        solr_response.highlight(self)
      end
    end
  end
end
