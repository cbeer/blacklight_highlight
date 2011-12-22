# Meant to be applied on top of a controller that implements
# Blacklight::SolrHelper. 
module BlacklightHighlight::ControllerExtension
  def self.included(some_class)
    some_class.helper BlacklightHighlightHelper
    some_class.send(:include, BlacklightHighlight::SolrHelperExtension)
  end
end

