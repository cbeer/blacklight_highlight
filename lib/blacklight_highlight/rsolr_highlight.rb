module BlacklightHighlight::RsolrHighlight
  module InstanceMethods
    def highlight field 
      highlights[field]
    end

    def highlights 
      return {} unless solr_response and solr_response['highlighting'] and solr_response['highlighting'][self.id]

      val = solr_response['highlighting'][self.id]

      val
    end

    def has? field
      return true if solr_response['highlighting'][self.id][field]
      super(field)
    end
  end
end
