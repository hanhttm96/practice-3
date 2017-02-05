# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {
  watchOptions:
    preferredMethods: ['watchFile', 'watch']
    catchupDelay: 0
    regenerateDelay: 0
  # Coppy js files from bootstrap-sass vendor to out folder
  plugins:
    raw:
      jquery:
        command: ['rsync', '-v', 'vendors/jquery/dist/jquery.min.js', 'vendors/bootstrap-sass/assets/javascripts/bootstrap.min.js', 'out/js/']
}

# Export the DocPad Configuration
module.exports = docpadConfig
