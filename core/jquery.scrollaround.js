;(function ( $, window, document, undefined ) {

    var pluginName = "scrollaround",
        defaults = {
          propertyName: "value"
        };

    function Plugin( element, options ) {
      this.element = element;
      this.options = $.extend( {}, defaults, options );
      this.init();
    }

    Plugin.prototype = {
      init: function() {
        console.log("Successful init")
      }
    };

    $.fn[pluginName] = function ( options ) {
      return this.each(function () {
        if (!$.data(this, "plugin_" + pluginName)) {
          $.data(this, "plugin_" + pluginName, new Plugin( this, options ));
        }
      });
    };

})( jQuery, window, document );