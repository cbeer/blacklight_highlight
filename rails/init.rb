require 'blacklight_highlight'

# We do our injection in after_initialize so an app can stop it or configure
# it in an initializer, using BlacklightHighlight.omit_inject .
# Only weirdness about this is our CSS will always be last, so if an app
# wants to over-ride it, might want to set BlacklightHighlight.omit_inject => {:css => true}
config.after_initialize do 
  BlacklightHighlight.inject!
end
