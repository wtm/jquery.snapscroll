(($, window, document, undefined_) ->
  pluginName = "snapscroll"
  defaults =
    scrollSpeed: 300
    scrollEndSpeed: 100

  Plugin = (element, options) ->
    @container = $(element)
    @options = $.extend({}, defaults, options)
    @init()

  Plugin:: =
    init: ->
      @snapping()
      @elastic()

    elastic: ->
      sa = @
      $scroller = $('.scroller')
      window_height = $(window).height();
      window_half =  window_height / 2;
      prev_position = $(document).scrollTop()
      elastic_scroll_speed = 100
      elastic_end_speed = 200
      easing = default_easing = 1
      link_opened = false

      $(window).on "scroll.elastic", ->
        cur_position = $(document).scrollTop()
        bottom_position = cur_position + $(window).height()
        direction = sa.getDirection(prev_position, cur_position)
        doc_height = $(document).height()
        scroll_ended = false

        if bottom_position > doc_height - $scroller.height() - 40
          easing = easing * 2;

          if direction is "down"

            if bottom_position >= $scroller.offset().top + window_half && !link_opened
              link_opened = true
              window.open($scroller.data("url"), "_self")
            else
              $scroller.css({height: "+="+easing+"px"})
          else
            easing = default_easing
            $scroller.css({height: "0px"})

        prev_position = cur_position

    snapping: ->
      sa = @
      $children = @container.children()

      scroll_speed = @options.scrollSpeed
      scroll_end_speed = @options.scrollEndSpeed
      prev_position = $(document).scrollTop()
      timer = null

      end_scroll = false
      autoscrolling = false
      

      $(window).on "scroll.snap", ->
        if !autoscrolling
          cur_position = $(document).scrollTop()
          direction = sa.getDirection(prev_position, cur_position)
          $child = sa.getTargetChild($children, direction, cur_position)
          
          # Always clear the timeout on new scroll
          clearTimeout timer

          timer = setTimeout ->
            $(window).scrollTo($child, scroll_speed)

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
      window_height = $(window).height()
      bottom_position = position + window_height
      snap_padding = 20
      fc_offset = $children.first().offset().top
      lc_offset = $children.last().offset().top + window_height
      $target = null

      if position + snap_padding > fc_offset and bottom_position - snap_padding < lc_offset
        $children.each (i) ->
          object_offset = $(this).offset().top

          if direction is "down"
            if bottom_position > object_offset
              $target = $(this)
          else
            if position < object_offset + window_height
              $target = $(this)
              return false

      return $target

  $.fn[pluginName] = (options) ->
    @each ->
      $.data this, "plugin_" + pluginName, new Plugin(this, options)  unless $.data(this, "plugin_" + pluginName)

) jQuery, window, document