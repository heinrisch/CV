// Generated by CoffeeScript 1.4.0
(function() {
  var Router, i, loadScript, startApp, startIfReady, _i, _len, _ref,
    _this = this;

  Router = Backbone.Router.extend({
    routes: {
      '': 'cv'
    },
    cv: function() {
      var view;
      console.log('Loading Main view');
      view = new MainView();
      console.log(view.render().el);
      return $('#skrollr-body').html(view.render().el);
    }
  });

  loadScript = function(url, callback) {
    var head, script;
    head = document.getElementsByTagName('head')[0];
    script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = url;
    script.onreadystatechange = callback;
    script.onload = callback;
    return head.appendChild(script);
  };

  this.includes = ['views/box_view.js', 'views/box_list_view.js', 'views/main_view.js', 'models/box.js', 'models/box_list.js'];

  this.includesCounter = this.includes.length;

  this.documentDone = false;

  _ref = this.includes;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    i = _ref[_i];
    console.log('including: ' + i);
    loadScript('javascripts/' + i, function() {
      console.log('Checking if ready: ' + _this.includesCounter);
      _this.includesCounter--;
      return startIfReady();
    });
  }

  startApp = function() {
    new Router();
    Backbone.history.start();
    skrollr.init({
      forceHeight: false
    });
    return $('.workbox').popover({
      trigger: 'hover',
      animation: true,
      placement: 'bottom'
    });
  };

  $(function() {
    _this.documentDone = true;
    return startIfReady();
  });

  startIfReady = function() {
    if (_this.documentDone && _this.includesCounter === 0) {
      return startApp();
    }
  };

}).call(this);
