# BlacklightHighlight
require 'rsolr-ext/response/highlight'

module BlacklightHighlight
  autoload :ControllerExtension, 'blacklight_highlight/controller_extension'
  autoload :SolrDocumentExtension, 'blacklight_highlight/solr_document_extension'
  autoload :SolrHelperExtension, 'blacklight_highlight/solr_helper_extension'

  require 'blacklight_highlight/version'
  require 'blacklight_highlight/engine'

end
