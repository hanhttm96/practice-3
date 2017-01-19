# DocPad Configuration File
# http://docpad.org/docs/config
# Define the DocPad Configuration
docpadConfig = {
  port: 8888
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
module.exports = docpadConfig;
# Export Plugin
module.exports = (BasePlugin) ->
  # Requires
  safeps = require('safeps')
  fs = require('fs')
  {TaskGroup} = require('taskgroup')

  # Define Plugin
  class SassPlugin extends BasePlugin
    # Plugin name
    name: 'sass'

    # Plugin config
    # Only on the development environment use expanded, otherwise use compressed
    config:
      sassPath: null
      scssPath: null
      compass: true
      debugInfo: false
      sourcemap: false
      outputStyle: 'compressed'
      requireLibraries: null
      renderUnderscoreStylesheets: false
      environments:
        development:
          outputStyle: 'expanded'

    # Locale
    locale:
      sassNotInstalled: 'SASS does not appear to be available on your system'
      scssNotInstalled: 'SCSS does not appear to be available on your system'

    # Generate Before
    generateBefore: (opts,next) ->
      # Prepare
      config = @config

      # Group
      tasks = new TaskGroup(concurrency:0).done(next)

      # Determine if compass is installed
      unless config.compass?
        tasks.addTask (complete) ->
          safeps.getExecPath 'compass', (err,path) ->
            config.compass = path?
            return complete()

      # Determine sass executable path
      ['sass','scss'].forEach (thing) ->
        unless config[thing+'Path']?
          tasks.addTask (complete) ->
            safeps.getExecPath thing, (err,path) ->
              config[thing+'Path'] = path ? false
              return complete()

      # Fire tasks
      tasks.run()

    # Prevent underscore
    extendCollections: (opts) ->
      # Prepare
      config = @config
      docpad = @docpad

      # Prevent underscore files from being written if desired
      if config.renderUnderscoreStylesheets is false
        @underscoreStylesheets = docpad.getDatabase().findAllLive(filename: /^_(.*?)\.(?:scss|sass)/)
        @underscoreStylesheets.on 'add', (model) ->
          model.set({
            render: false
            write: false
          })

    # Render some content
    render: (opts,next) ->
      # Prepare
      config = @config
      locale = @locale
      {inExtension,outExtension,file} = opts

      # If SASS/SCSS then render
      if inExtension in ['sass','scss'] and outExtension in ['css',null]
        # Fetch useful paths
        fullDirPath = file.get('fullDirPath')

        # Prepare the command and options
        commandOpts = {}
        execPath = config[inExtension+'Path']

        # Check if we have the executable for that extension
        return next(new Error(locale[inExtension+'NotInstalled']))  unless execPath

        # Set referencesOthers if this document imports, as sass concatenates files together
        file.setMetaDefaults('referencesOthers': true)  if opts.content.indexOf('@import') isnt -1

        # Build our command
        command = [].concat(execPath)
        # ^ execPath can be an array or string, see https://github.com/docpad/docpad-plugin-sass/pull/26

        # Sourcemaps or stdin?
        if config.sourcemap
          command.push("#{file.attributes.fullPath}:#{file.attributes.outPath}", '--no-cache', '--update', '--sourcemap')
        else
          command.push('--no-cache', '--stdin')
          commandOpts.stdin = opts.content

        if fullDirPath
          command.push('--load-path')
          command.push(fullDirPath)

        if config.compass
          command.push('--compass')

        if config.debugInfo
          command.push('--debug-info')

        if config.outputStyle
          command.push('--style')
          command.push(config.outputStyle)

        if config.requireLibraries
          for name in config.requireLibraries
            command.push('--require')
            command.push(name)

        # Spawn the appropriate process to render the content
        safeps.spawn command, commandOpts, (err,stdout,stderr,code,signal) ->
          if err
            err.message += '\n\n'+(stderr or stdout)
            return next(err)

          if config.sourcemap
            opts.content = fs.readFileSync(file.attributes.outPath).toString()
          else
            opts.content = stdout

          return next()

      else
        # Done, return back to DocPad
        return next()
