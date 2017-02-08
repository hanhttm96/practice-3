
# DocPad Configuration File
# http://docpad.org/docs/config
# Define the DocPad Configuration
docpadConfig = {
  port: 8889
  watchOptions:
    preferredMethods: ['watchFile', 'watch']
    catchupDelay: 0
    regenerateDelay: 0
  templateData:
    url: "index.html"
    site:
      title: ""
      description: """
        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam
        """
      keywords: """
        blog, porfolio, single page
        """
      author: "Hanh Tran"
    getPreparedTitle: ->
      if @document.title
        "#{@document.title} | #{@site.title}"
      else
        @site.title
    getPreparedDescription: ->
      @document.description or @site.description
    getPreparedKeywords: ->
      @site.keywords.concat(@document.keywords or []).join(', ')
}
# Export the DocPad Configuration
module.exports = docpadConfig
# Export Plugin
