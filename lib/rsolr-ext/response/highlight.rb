module RSolr
  module Ext
    module Response
      module Highlight
        def highlight document, field = nil
          doc_highlights = highlights[document.id]
          doc_highlights ||= {}

          return doc_highlights[field] if field

          doc_highlights
        end
    
        def highlights 
          return {} unless self.respond_to?(:response) and self.response[:highlighting] 
    
          @highlights ||= self.response[:highlighting]
        end
      end
    end
  end
end
