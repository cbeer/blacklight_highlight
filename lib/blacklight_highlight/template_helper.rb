# Meant to be applied on top of Blacklight helpers
module BlacklightHighlight::TemplateHelper

  def render_index_field_value args
    if args[:field] and Blacklight.config[:index_fields][:highlight] and Blacklight.config[:index_fields][:highlight].include?(args[:field])
      args[:value] ||= render_highlight_field_value(args)
    end


    super(args)
  end

  def render_document_show_field_value args
    if args[:field] and Blacklight.config[:show_fields][:highlight] and Blacklight.config[:show_fields][:highlight].include?(args[:field])
      args[:value] ||= render_highlight_field_value(args)
    end

    super(args)
  end

  def render_highlight_field_value args
     value = args[:document].highlight(args[:field])
     
     raw(value) # unless value.blank?
  end

end

