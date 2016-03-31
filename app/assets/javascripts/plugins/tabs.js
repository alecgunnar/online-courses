(function ($) {
    var numTabs              = 0,
        FANCY_TABS_DELIMITER = 't';

    $.fn.fancyTabs = function () {
        var $this,
            id,
            settings,
            tabs,
            active,
            methods;

        $this = $(this);
        id    = numTabs++;

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
                        button:  $(this),
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

                methods.updateHash();
            },
            getTabSets: function () {
                return window.location.hash.substr(1).split(FANCY_TABS_DELIMITER);
            },
            updateHash: function () {
                var tabSets = methods.getTabSets();

                tabSets[id]          = tabs.indexOf(active);
                console.log(tabSets);
                window.location.hash = tabSets.join(FANCY_TABS_DELIMITER);
            },
            determineActive: function () {
                var tabSets = methods.getTabSets();

                return tabSets[id] ? tabSets[id] : 0;
            },
            initialize: function () {
                methods.mapTabs();
                methods.createListeners();

                if (tabs.length)
                    methods.activateTab(tabs[methods.determineActive()]);

                return true;
            }
        };

        return methods.initialize();
    };
})(jQuery);
