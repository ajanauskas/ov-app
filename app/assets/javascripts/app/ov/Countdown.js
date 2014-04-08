(function(OV) {
  var Countdown = {
    initialize: function(options) {
      this.$el = options.$el;

      this.tick();

      setInterval(this.tick, 1000);
    },

    template: function(until) {
      var appearsIn = "";

      if (until.getMinutes() > 0) {
        appearsIn += until.getMinutes() + " minučių ";
      }

      appearsIn += until.getSeconds() + " sekundžių";

      return "Sekantis patarimas už " + appearsIn;
    },

    tick: function() {
      var that = Countdown;
      var timeNow = new Date(Date.now());

      $.each(that.$el, function(index, el) {
        var $el = $(el)
        var until = new Date($el.data('countdown-until'));

        if (timeNow > until) {
          window.location.reload();
        } else {
          $el.html(that.template(new Date(until - timeNow)));
        }
      });
    }
  };

  OV.Countdown = Countdown;

})(window.OV = window.OV || {});
