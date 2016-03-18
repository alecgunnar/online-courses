(function ($) {
    $.fn.fancyTabs = function () {
        var $this,
            settings,
            tabs,
            active,
            methods;

        $this = $(this);

        settings = {
            tab_nav_class:             'tabs__nav',
            tab_button_class:          'tabs__button',
            tab_content_class:         'tabs__content',
            tab_active_button_class:   'tabs__button--active',
            tab_active_content_class:  'tabs__content--active'
        };

        tabs   = [];
        active = false;

        methods = {
            mapTabs: function() {
                var contents = $this.find('.' + settings.tab_content_class);

                $this.find('.' + settings.tab_button_class).each(function () {
                    tabs[tabs.length] = {
                        button: $(this),
                        content: $(contents[tabs.length])
                    };
                });
            },
            createListeners: function () {
                tabs.forEach(function (e) {
                    e.button.on('click tap', function () {
                        methods.activateTab(e);
                    });
                });
            },
            toggleActive: function (t) {
                t.button.toggleClass(settings.tab_active_button_class);
                t.content.toggleClass(settings.tab_active_content_class);
            },
            activateTab: function (t) {
                if (active)
                    methods.toggleActive(active);

                methods.toggleActive(active = t);
            },
            initialize: function () {
                methods.mapTabs();
                methods.createListeners();

                if (tabs.length)
                    methods.activateTab(tabs[0]);

                return true;
            }
        };

        return methods.initialize();
    };
})(jQuery);
