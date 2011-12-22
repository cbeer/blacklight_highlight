# Meant to be applied on top of Blacklight helpers
module BlacklightHighlight::SolrHelperExtension
  def self.included some_class
    some_class.solr_search_params_logic += [:solr_highlight_params]
  end

  def solr_highlight_params solr_parameters, user_parameters

    if solr_parameters['q'] || solr_parameters['hl.q'] || solr_parameters[:q] || solr_parameters[:'hl.q']
      solr_parameters[:hl] ||= true
      solr_parameters[:'hl.fl'] ||= ''
      solr_parameters[:'hl.fl'] += blacklight_config.index_fields.select { |key, config| config.highlight }.map { |key, config| config.field }.join(",")
    end
  end
end

