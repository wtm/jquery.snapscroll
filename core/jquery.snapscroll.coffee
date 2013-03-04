(($, window, document, undefined_) ->
  pluginName = "snapscroll"
  defaults =
    botPadding: 40
    topPadding: 40
    scrollSpeed: 300
    scrollEndSpeed: 100

  Plugin = (element, options) ->
    @container = $(element)
    @options = $.extend({}, defaults, options)
    @init()

  Plugin:: =
    init: ->
      @snapping()

    snapping: ->
      $children = @container.children()

      scroll_speed = @options.scrollSpeed
      scroll_end_speed = @options.scrollEndSpeed
      prev_position = $(document).scrollTop()
      timer = null
      autoscrolling = false

      $(window).off("scroll.snapscroll").on  "scroll.snapscroll", =>
        if !autoscrolling
          cur_position = $(document).scrollTop()
          direction = @getDirection(prev_position, cur_position)
          $child = @getTargetChild($children, direction, cur_position)

          # Always clear the timeout on new scroll
          if $child
            clearTimeout timer

            timer = setTimeout ->
              $(window).scrollTo($child, scroll_speed)
              $child.siblings(".ss-active").removeClass("ss-active")
              $child.addClass("ss-active")

              # Prevent scrollTo from calling itself
              autoscrolling = true
              setTimeout ->
                prev_position = $(document).scrollTop()
                autoscrolling = false
              , scroll_speed + 20

            , scroll_end_speed

          prev_position = cur_position


    getDirection: (a, b) ->
      if a > b then "up" else "down"

    getTargetChild: ($children, direction, position) ->
      options = @options
      window_height = $(window).height()
      bottom_position = position + window_height
      fc_top = $children.first().offset().top
      lc_bottom = $children.last().offset().top + window_height
      $target = null

      if fc_top < position + options.topPadding
        $children.not(".ss-active").each (i) ->
          object_top = $(this).offset().top
          object_bot = object_top + $(this).height();

          if direction is "down"
            if object_top < bottom_position and object_bot > position
              $target = $(this)
              return false
          else
            if object_top < position and position < object_bot
              $target = $(this)

      return $target

  $.fn[pluginName] = (options) ->
    @each ->
      $.data this, "plugin_" + pluginName, new Plugin(this, options) unless $.data(this, "plugin_" + pluginName)

) jQuery, window, document