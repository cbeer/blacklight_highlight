# Meant to be applied on top of Blacklight helpers
module BlacklightHighlight::SolrHelperOverride
  def solr_search_params(extra_controller_params={})
    result = super(extra_controller_params)
    solr_highlight_params.deep_merge result
  end

  def solr_highlight_params
    { :hl => true }.deep_merge(highlight_config)
  end
end

