# BlacklightHighlight

module BlacklightHighlight
  @omit_inject = {}
  def self.omit_inject=(value)
    value = Hash.new(true) if value == true
    @omit_inject = value      
  end
  def self.omit_inject ; @omit_inject ; end
  
  def self.inject!
    Dispatcher.to_prepare do
      unless omit_inject[:view_helpers]
        CatalogController.send(:include, BlacklightHighlight::SolrHelperOverride) unless CatalogController.include?(BlacklightHighlight::SolrHelperOverride)
        CatalogController.add_template_helper(BlacklightHighlight::TemplateHelper) unless CatalogController.master_helper_module.include?(BlacklightHighlight::TemplateHelper)
      end

      unless omit_inject[:controller_mixin]
        CatalogController.send(:include, BlacklightHighlight::ControllerOverride) unless CatalogController.include?(BlacklightHighlight::ControllerOverride)
      end

      unless omit_inject[:rsolr_plugin]
        SolrDocument.plugin(BlacklightHighlight::RsolrHighlight) unless SolrDocument.plugins.include?(BlacklightHighlight::RsolrHighlight)
      end

    end
  end

  # Add element to array only if it's not already there
  def self.safe_arr_add(array, element)
    array << element unless array.include?(element)
  end
  
end
