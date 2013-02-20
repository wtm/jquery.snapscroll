(($, window, document, undefined_) ->
  pluginName = "snapscroll"
  defaults =
    scrollSpeed: 300
    scrollOffset: 50

  Plugin = (element, options) ->
    @container = $(element)
    @options = $.extend({}, defaults, options)
    @init()

  Plugin:: =
    init: ->
      @scrollInit()

    scrollInit: ->
      sa = @
      scroll_speed = @options.scrollSpeed
      scroll_offset = @options.scrollOffset
      $children = @container.children()

      prev_position = $(document).scrollTop()
      end_scroll = false
      timer = null
      
      # The scroll event
      $(window).on "scroll.snapscroll", ->
        cur_position = $(document).scrollTop()
        
        # Always clear the timeout on new scroll
        clearTimeout timer

        unless end_scroll
          # If this is not a double auto scroll...
          direction = sa.getDirection(prev_position, cur_position)
          $child = sa.getTargetChild($children, direction, cur_position)

          timer = setTimeout ->
            $(window).scrollTo $child, scroll_speed
            setTimeout ->
              
              # Prevent double auto-scroll
              end_scroll = true
            , scroll_speed
          , scroll_offset
        else
          # Allow auto-scrolling again
          end_scroll = false
        
        # For detecting direction
        prev_position = cur_position


    getDirection: (a, b) ->
      if a > b then "up" else "down"

    getTargetChild: ($children, direction, position) ->
      window_height = $children.first().height()
      window_half = window_height / 2
      $target = null

      $children.each ->
        offsetY = $(this).offset().top
        if direction is "up"
          $target = $(this) if offsetY < position and position < offsetY + window_height
        else
          $target = $(this) if offsetY < position + window_height and position < offsetY

      $target

  $.fn[pluginName] = (options) ->
    @each ->
      $.data this, "plugin_" + pluginName, new Plugin(this, options)  unless $.data(this, "plugin_" + pluginName)

) jQuery, window, document