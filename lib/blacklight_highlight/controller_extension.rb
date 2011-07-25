# Meant to be applied on top of a controller that implements
# Blacklight::SolrHelper. 
module BlacklightHighlight::ControllerExtension
  def self.included(some_class)
    some_class.helper_method :highlight_config
    some_class.helper BlacklightHighlightHelper
  end

  # Uses Blacklight.config, needs to be modified when
  # that changes to be controller-based. This is the only method
  # in this plugin that accesses Blacklight.config, single point
  # of contact. 
  def highlight_config
    Blacklight.config[:highlight] || {}
  end
end

