;html
  ;head
    ;meta(name "viewport", content "width=device-width, initial-scale=1");
    ;meta(name "apple-mobile-web-app-capable", content "yes");
    ;meta(name "mobile-web-app-capable", content "yes");

    ;script(type "text/javascript", src "//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js");
    ;script(type "text/javascript", src "/~/at/lib/js/urb.js");
    ;script(type "text/javascript", src "/pages/wiki/vue/vue.js");
    ;script(type "text/javascript", src "/pages/wiki/vue-router/vue-router.js");
    ;script(type "text/javascript", src "//unpkg.com/bootstrap-vue@0.18.0/dist/bootstrap-vue.js");
    ;script(type "text/javascript", src "/pages/wiki/marked/marked.min.js");

    ;title:"Wiki"

    ;link(type "text/css", rel "stylesheet", href "//unpkg.com/bootstrap@4.0.0-alpha.6/dist/css/bootstrap.min.css");
    ;link(type "text/css", rel "stylesheet", href "//unpkg.com/bootstrap-vue@0.18.0/dist/bootstrap-vue.css");
    ;link(type "text/css", rel "stylesheet", href "/pages/wiki/wiki.css");
  ==
  ;body
    ;div#app
      ;router-view;
    ==
    ;footer
      ;small
        ;a/"https://github.com/asssaf/urbit-wiki"(target "_blank"): Source
      ==
    ==

    ;script(type "text/javascript", src "/pages/wiki/main.js");
  ==
==
