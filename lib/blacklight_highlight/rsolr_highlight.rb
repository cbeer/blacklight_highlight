module BlacklightHighlight::RsolrHighlight
  module InstanceMethods
    def highlight key 
      highlights[key]
    end

    def highlights 
      return {} unless solr_response and solr_response['highlighting'] and solr_response['highlighting'][self.id]

      val = solr_response['highlighting'][self.id]

      val
    end
  end
end
