# Meant to be applied on top of Blacklight helpers
module BlacklightHighlight::SolrHelperOverride
  def self.included some_class
    some_class.solr_search_params_logic += [:solr_highlight_params]
  end

  def solr_highlight_params solr_parameters, user_parameters
    solr_parameters[:hl] ||= true
  end
end

