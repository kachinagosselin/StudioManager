/**
* bootstrap.js v3.0.0 by @fat and @mdo
* Copyright 2013 Twitter Inc.
* http://www.apache.org/licenses/LICENSE-2.0
*/
if(!jQuery)throw new Error("Bootstrap requires jQuery");/* ========================================================================
 * Bootstrap: transition.js v3.0.0
 * http://twbs.github.com/bootstrap/javascript.html#transitions
 * ========================================================================
 * Copyright 2013 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ======================================================================== */
+function(t){"use strict";function e(){var t=document.createElement("bootstrap"),e={WebkitTransition:"webkitTransitionEnd",MozTransition:"transitionend",OTransition:"oTransitionEnd otransitionend",transition:"transitionend"};for(var i in e)if(void 0!==t.style[i])return{end:e[i]}}t.fn.emulateTransitionEnd=function(e){var i=!1,n=this;t(this).one(t.support.transition.end,function(){i=!0});var s=function(){i||t(n).trigger(t.support.transition.end)};return setTimeout(s,e),this},t(function(){t.support.transition=e()})}(window.jQuery),/* ========================================================================
 * Bootstrap: alert.js v3.0.0
 * http://twbs.github.com/bootstrap/javascript.html#alerts
 * ========================================================================
 * Copyright 2013 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ======================================================================== */
+function(t){"use strict";var e='[data-dismiss="alert"]',i=function(i){t(i).on("click",e,this.close)};i.prototype.close=function(e){function i(){o.trigger("closed.bs.alert").remove()}var n=t(this),s=n.attr("data-target");s||(s=n.attr("href"),s=s&&s.replace(/.*(?=#[^\s]*$)/,""));var o=t(s);e&&e.preventDefault(),o.length||(o=n.hasClass("alert")?n:n.parent()),o.trigger(e=t.Event("close.bs.alert")),e.isDefaultPrevented()||(o.removeClass("in"),t.support.transition&&o.hasClass("fade")?o.one(t.support.transition.end,i).emulateTransitionEnd(150):i())};var n=t.fn.alert;t.fn.alert=function(e){return this.each(function(){var n=t(this),s=n.data("bs.alert");s||n.data("bs.alert",s=new i(this)),"string"==typeof e&&s[e].call(n)})},t.fn.alert.Constructor=i,t.fn.alert.noConflict=function(){return t.fn.alert=n,this},t(document).on("click.bs.alert.data-api",e,i.prototype.close)}(window.jQuery),/* ========================================================================
 * Bootstrap: button.js v3.0.0
 * http://twbs.github.com/bootstrap/javascript.html#buttons
 * ========================================================================
 * Copyright 2013 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ======================================================================== */
+function(t){"use strict";var e=function(i,n){this.$element=t(i),this.options=t.extend({},e.DEFAULTS,n)};e.DEFAULTS={loadingText:"loading..."},e.prototype.setState=function(t){var e="disabled",i=this.$element,n=i.is("input")?"val":"html",s=i.data();t+="Text",s.resetText||i.data("resetText",i[n]()),i[n](s[t]||this.options[t]),setTimeout(function(){"loadingText"==t?i.addClass(e).attr(e,e):i.removeClass(e).removeAttr(e)},0)},e.prototype.toggle=function(){var t=this.$element.closest('[data-toggle="buttons"]');if(t.length){var e=this.$element.find("input").prop("checked",!this.$element.hasClass("active")).trigger("change");"radio"===e.prop("type")&&t.find(".active").removeClass("active")}this.$element.toggleClass("active")};var i=t.fn.button;t.fn.button=function(i){return this.each(function(){var n=t(this),s=n.data("bs.button"),o="object"==typeof i&&i;s||n.data("bs.button",s=new e(this,o)),"toggle"==i?s.toggle():i&&s.setState(i)})},t.fn.button.Constructor=e,t.fn.button.noConflict=function(){return t.fn.button=i,this},t(document).on("click.bs.button.data-api","[data-toggle^=button]",function(e){var i=t(e.target);i.hasClass("btn")||(i=i.closest(".btn")),i.button("toggle"),e.preventDefault()})}(window.jQuery),/* ========================================================================
 * Bootstrap: carousel.js v3.0.0
 * http://twbs.github.com/bootstrap/javascript.html#carousel
 * ========================================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ======================================================================== */
+function(t){"use strict";var e=function(e,i){this.$element=t(e),this.$indicators=this.$element.find(".carousel-indicators"),this.options=i,this.paused=this.sliding=this.interval=this.$active=this.$items=null,"hover"==this.options.pause&&this.$element.on("mouseenter",t.proxy(this.pause,this)).on("mouseleave",t.proxy(this.cycle,this))};e.DEFAULTS={interval:5e3,pause:"hover",wrap:!0},e.prototype.cycle=function(e){return e||(this.paused=!1),this.interval&&clearInterval(this.interval),this.options.interval&&!this.paused&&(this.interval=setInterval(t.proxy(this.next,this),this.options.interval)),this},e.prototype.getActiveIndex=function(){return this.$active=this.$element.find(".item.active"),this.$items=this.$active.parent().children(),this.$items.index(this.$active)},e.prototype.to=function(e){var i=this,n=this.getActiveIndex();return e>this.$items.length-1||0>e?void 0:this.sliding?this.$element.one("slid",function(){i.to(e)}):n==e?this.pause().cycle():this.slide(e>n?"next":"prev",t(this.$items[e]))},e.prototype.pause=function(e){return e||(this.paused=!0),this.$element.find(".next, .prev").length&&t.support.transition.end&&(this.$element.trigger(t.support.transition.end),this.cycle(!0)),this.interval=clearInterval(this.interval),this},e.prototype.next=function(){return this.sliding?void 0:this.slide("next")},e.prototype.prev=function(){return this.sliding?void 0:this.slide("prev")},e.prototype.slide=function(e,i){var n=this.$element.find(".item.active"),s=i||n[e](),o=this.interval,a="next"==e?"left":"right",r="next"==e?"first":"last",l=this;if(!s.length){if(!this.options.wrap)return;s=this.$element.find(".item")[r]()}this.sliding=!0,o&&this.pause();var h=t.Event("slide.bs.carousel",{relatedTarget:s[0],direction:a});if(!s.hasClass("active")){if(this.$indicators.length&&(this.$indicators.find(".active").removeClass("active"),this.$element.one("slid",function(){var e=t(l.$indicators.children()[l.getActiveIndex()]);e&&e.addClass("active")})),t.support.transition&&this.$element.hasClass("slide")){if(this.$element.trigger(h),h.isDefaultPrevented())return;s.addClass(e),s[0].offsetWidth,n.addClass(a),s.addClass(a),n.one(t.support.transition.end,function(){s.removeClass([e,a].join(" ")).addClass("active"),n.removeClass(["active",a].join(" ")),l.sliding=!1,setTimeout(function(){l.$element.trigger("slid")},0)}).emulateTransitionEnd(600)}else{if(this.$element.trigger(h),h.isDefaultPrevented())return;n.removeClass("active"),s.addClass("active"),this.sliding=!1,this.$element.trigger("slid")}return o&&this.cycle(),this}};var i=t.fn.carousel;t.fn.carousel=function(i){return this.each(function(){var n=t(this),s=n.data("bs.carousel"),o=t.extend({},e.DEFAULTS,n.data(),"object"==typeof i&&i),a="string"==typeof i?i:o.slide;s||n.data("bs.carousel",s=new e(this,o)),"number"==typeof i?s.to(i):a?s[a]():o.interval&&s.pause().cycle()})},t.fn.carousel.Constructor=e,t.fn.carousel.noConflict=function(){return t.fn.carousel=i,this},t(document).on("click.bs.carousel.data-api","[data-slide], [data-slide-to]",function(e){var i,n=t(this),s=t(n.attr("data-target")||(i=n.attr("href"))&&i.replace(/.*(?=#[^\s]+$)/,"")),o=t.extend({},s.data(),n.data()),a=n.attr("data-slide-to");a&&(o.interval=!1),s.carousel(o),(a=n.attr("data-slide-to"))&&s.data("bs.carousel").to(a),e.preventDefault()}),t(window).on("load",function(){t('[data-ride="carousel"]').each(function(){var e=t(this);e.carousel(e.data())})})}(window.jQuery),/* ========================================================================
 * Bootstrap: collapse.js v3.0.0
 * http://twbs.github.com/bootstrap/javascript.html#collapse
 * ========================================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ======================================================================== */
+function(t){"use strict";var e=function(i,n){this.$element=t(i),this.options=t.extend({},e.DEFAULTS,n),this.transitioning=null,this.options.parent&&(this.$parent=t(this.options.parent)),this.options.toggle&&this.toggle()};e.DEFAULTS={toggle:!0},e.prototype.dimension=function(){var t=this.$element.hasClass("width");return t?"width":"height"},e.prototype.show=function(){if(!this.transitioning&&!this.$element.hasClass("in")){var e=t.Event("show.bs.collapse");if(this.$element.trigger(e),!e.isDefaultPrevented()){var i=this.$parent&&this.$parent.find("> .panel > .in");if(i&&i.length){var n=i.data("bs.collapse");if(n&&n.transitioning)return;i.collapse("hide"),n||i.data("bs.collapse",null)}var s=this.dimension();this.$element.removeClass("collapse").addClass("collapsing")[s](0),this.transitioning=1;var o=function(){this.$element.removeClass("collapsing").addClass("in")[s]("auto"),this.transitioning=0,this.$element.trigger("shown.bs.collapse")};if(!t.support.transition)return o.call(this);var a=t.camelCase(["scroll",s].join("-"));this.$element.one(t.support.transition.end,t.proxy(o,this)).emulateTransitionEnd(350)[s](this.$element[0][a])}}},e.prototype.hide=function(){if(!this.transitioning&&this.$element.hasClass("in")){var e=t.Event("hide.bs.collapse");if(this.$element.trigger(e),!e.isDefaultPrevented()){var i=this.dimension();this.$element[i](this.$element[i]())[0].offsetHeight,this.$element.addClass("collapsing").removeClass("collapse").removeClass("in"),this.transitioning=1;var n=function(){this.transitioning=0,this.$element.trigger("hidden.bs.collapse").removeClass("collapsing").addClass("collapse")};return t.support.transition?(this.$element[i](0).one(t.support.transition.end,t.proxy(n,this)).emulateTransitionEnd(350),void 0):n.call(this)}}},e.prototype.toggle=function(){this[this.$element.hasClass("in")?"hide":"show"]()};var i=t.fn.collapse;t.fn.collapse=function(i){return this.each(function(){var n=t(this),s=n.data("bs.collapse"),o=t.extend({},e.DEFAULTS,n.data(),"object"==typeof i&&i);s||n.data("bs.collapse",s=new e(this,o)),"string"==typeof i&&s[i]()})},t.fn.collapse.Constructor=e,t.fn.collapse.noConflict=function(){return t.fn.collapse=i,this},t(document).on("click.bs.collapse.data-api","[data-toggle=collapse]",function(e){var i,n=t(this),s=n.attr("data-target")||e.preventDefault()||(i=n.attr("href"))&&i.replace(/.*(?=#[^\s]+$)/,""),o=t(s),a=o.data("bs.collapse"),r=a?"toggle":n.data(),l=n.attr("data-parent"),h=l&&t(l);a&&a.transitioning||(h&&h.find('[data-toggle=collapse][data-parent="'+l+'"]').not(n).addClass("collapsed"),n[o.hasClass("in")?"addClass":"removeClass"]("collapsed")),o.collapse(r)})}(window.jQuery),/* ========================================================================
 * Bootstrap: dropdown.js v3.0.0
 * http://twbs.github.com/bootstrap/javascript.html#dropdowns
 * ========================================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ======================================================================== */
+function(t){"use strict";function e(){t(n).remove(),t(s).each(function(e){var n=i(t(this));n.hasClass("open")&&(n.trigger(e=t.Event("hide.bs.dropdown")),e.isDefaultPrevented()||n.removeClass("open").trigger("hidden.bs.dropdown"))})}function i(e){var i=e.attr("data-target");i||(i=e.attr("href"),i=i&&/#/.test(i)&&i.replace(/.*(?=#[^\s]*$)/,""));var n=i&&t(i);return n&&n.length?n:e.parent()}var n=".dropdown-backdrop",s="[data-toggle=dropdown]",o=function(e){t(e).on("click.bs.dropdown",this.toggle)};o.prototype.toggle=function(n){var s=t(this);if(!s.is(".disabled, :disabled")){var o=i(s),a=o.hasClass("open");if(e(),!a){if("ontouchstart"in document.documentElement&&t('<div class="dropdown-backdrop"/>').insertAfter(t(this)).on("click",e),o.trigger(n=t.Event("show.bs.dropdown")),n.isDefaultPrevented())return;o.toggleClass("open").trigger("shown.bs.dropdown")}return s.focus(),!1}},o.prototype.keydown=function(e){if(/(38|40|27)/.test(e.keyCode)){var n=t(this);if(e.preventDefault(),e.stopPropagation(),!n.is(".disabled, :disabled")){var o=i(n),a=o.hasClass("open");if(!a||a&&27==e.keyCode)return 27==e.which&&o.find(s).focus(),n.click();var r=t("[role=menu] li:not(.divider):visible a",o);if(r.length){var l=r.index(r.filter(":focus"));38==e.keyCode&&l>0&&l--,40==e.keyCode&&l<r.length-1&&l++,~l||(l=0),r.eq(l).focus()}}}};var a=t.fn.dropdown;t.fn.dropdown=function(e){return this.each(function(){var i=t(this),n=i.data("dropdown");n||i.data("dropdown",n=new o(this)),"string"==typeof e&&n[e].call(i)})},t.fn.dropdown.Constructor=o,t.fn.dropdown.noConflict=function(){return t.fn.dropdown=a,this},t(document).on("click.bs.dropdown.data-api",e).on("click.bs.dropdown.data-api",".dropdown form",function(t){t.stopPropagation()}).on("click.bs.dropdown.data-api",s,o.prototype.toggle).on("keydown.bs.dropdown.data-api",s+", [role=menu]",o.prototype.keydown)}(window.jQuery),/* ========================================================================
 * Bootstrap: modal.js v3.0.0
 * http://twbs.github.com/bootstrap/javascript.html#modals
 * ========================================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ======================================================================== */
+function(t){"use strict";var e=function(e,i){this.options=i,this.$element=t(e).on("click.dismiss.modal",'[data-dismiss="modal"]',t.proxy(this.hide,this)),this.$backdrop=this.isShown=null,this.options.remote&&this.$element.load(this.options.remote)};e.DEFAULTS={backdrop:!0,keyboard:!0,show:!0},e.prototype.toggle=function(t){return this[this.isShown?"hide":"show"](t)},e.prototype.show=function(e){var i=this,n=t.Event("show.bs.modal",{relatedTarget:e});this.$element.trigger(n),this.isShown||n.isDefaultPrevented()||(this.isShown=!0,this.escape(),this.backdrop(function(){var n=t.support.transition&&i.$element.hasClass("fade");i.$element.parent().length||i.$element.appendTo(document.body),i.$element.show(),n&&i.$element[0].offsetWidth,i.$element.addClass("in").attr("aria-hidden",!1),i.enforceFocus();var s=t.Event("shown.bs.modal",{relatedTarget:e});n?i.$element.one(t.support.transition.end,function(){i.$element.focus().trigger(s)}).emulateTransitionEnd(300):i.$element.focus().trigger(s)}))},e.prototype.hide=function(e){e&&e.preventDefault(),e=t.Event("hide.bs.modal"),this.$element.trigger(e),this.isShown&&!e.isDefaultPrevented()&&(this.isShown=!1,this.escape(),t(document).off("focusin.bs.modal"),this.$element.removeClass("in").attr("aria-hidden",!0).off("click.dismiss.modal"),t.support.transition&&this.$element.hasClass("fade")?this.$element.one(t.support.transition.end,t.proxy(this.hideModal,this)).emulateTransitionEnd(300):this.hideModal())},e.prototype.enforceFocus=function(){t(document).off("focusin.bs.modal").on("focusin.bs.modal",t.proxy(function(t){this.$element[0]===t.target||this.$element.has(t.target).length||this.$element.focus()},this))},e.prototype.escape=function(){this.isShown&&this.options.keyboard?this.$element.on("keyup.dismiss.bs.modal",t.proxy(function(t){27==t.which&&this.hide()},this)):this.isShown||this.$element.off("keyup.dismiss.bs.modal")},e.prototype.hideModal=function(){var t=this;this.$element.hide(),this.backdrop(function(){t.removeBackdrop(),t.$element.trigger("hidden.bs.modal")})},e.prototype.removeBackdrop=function(){this.$backdrop&&this.$backdrop.remove(),this.$backdrop=null},e.prototype.backdrop=function(e){var i=this.$element.hasClass("fade")?"fade":"";if(this.isShown&&this.options.backdrop){var n=t.support.transition&&i;if(this.$backdrop=t('<div class="modal-backdrop '+i+'" />').appendTo(document.body),this.$element.on("click.dismiss.modal",t.proxy(function(t){t.target===t.currentTarget&&("static"==this.options.backdrop?this.$element[0].focus.call(this.$element[0]):this.hide.call(this))},this)),n&&this.$backdrop[0].offsetWidth,this.$backdrop.addClass("in"),!e)return;n?this.$backdrop.one(t.support.transition.end,e).emulateTransitionEnd(150):e()}else!this.isShown&&this.$backdrop?(this.$backdrop.removeClass("in"),t.support.transition&&this.$element.hasClass("fade")?this.$backdrop.one(t.support.transition.end,e).emulateTransitionEnd(150):e()):e&&e()};var i=t.fn.modal;t.fn.modal=function(i,n){return this.each(function(){var s=t(this),o=s.data("bs.modal"),a=t.extend({},e.DEFAULTS,s.data(),"object"==typeof i&&i);o||s.data("bs.modal",o=new e(this,a)),"string"==typeof i?o[i](n):a.show&&o.show(n)})},t.fn.modal.Constructor=e,t.fn.modal.noConflict=function(){return t.fn.modal=i,this},t(document).on("click.bs.modal.data-api",'[data-toggle="modal"]',function(e){var i=t(this),n=i.attr("href"),s=t(i.attr("data-target")||n&&n.replace(/.*(?=#[^\s]+$)/,"")),o=s.data("modal")?"toggle":t.extend({remote:!/#/.test(n)&&n},s.data(),i.data());e.preventDefault(),s.modal(o,this).one("hide",function(){i.is(":visible")&&i.focus()})}),t(document).on("shown.bs.modal",".modal",function(){t(document.body).addClass("modal-open")}).on("hidden.bs.modal",".modal",function(){t(document.body).removeClass("modal-open")})}(window.jQuery),/* ========================================================================
 * Bootstrap: tooltip.js v3.0.0
 * http://twbs.github.com/bootstrap/javascript.html#tooltip
 * Inspired by the original jQuery.tipsy by Jason Frame
 * ========================================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ======================================================================== */
+function(t){"use strict";var e=function(t,e){this.type=this.options=this.enabled=this.timeout=this.hoverState=this.$element=null,this.init("tooltip",t,e)};e.DEFAULTS={animation:!0,placement:"top",selector:!1,template:'<div class="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',trigger:"hover focus",title:"",delay:0,html:!1,container:!1},e.prototype.init=function(e,i,n){this.enabled=!0,this.type=e,this.$element=t(i),this.options=this.getOptions(n);for(var s=this.options.trigger.split(" "),o=s.length;o--;){var a=s[o];if("click"==a)this.$element.on("click."+this.type,this.options.selector,t.proxy(this.toggle,this));else if("manual"!=a){var r="hover"==a?"mouseenter":"focus",l="hover"==a?"mouseleave":"blur";this.$element.on(r+"."+this.type,this.options.selector,t.proxy(this.enter,this)),this.$element.on(l+"."+this.type,this.options.selector,t.proxy(this.leave,this))}}this.options.selector?this._options=t.extend({},this.options,{trigger:"manual",selector:""}):this.fixTitle()},e.prototype.getDefaults=function(){return e.DEFAULTS},e.prototype.getOptions=function(e){return e=t.extend({},this.getDefaults(),this.$element.data(),e),e.delay&&"number"==typeof e.delay&&(e.delay={show:e.delay,hide:e.delay}),e},e.prototype.getDelegateOptions=function(){var e={},i=this.getDefaults();return this._options&&t.each(this._options,function(t,n){i[t]!=n&&(e[t]=n)}),e},e.prototype.enter=function(e){var i=e instanceof this.constructor?e:t(e.currentTarget)[this.type](this.getDelegateOptions()).data("bs."+this.type);return clearTimeout(i.timeout),i.options.delay&&i.options.delay.show?(i.hoverState="in",i.timeout=setTimeout(function(){"in"==i.hoverState&&i.show()},i.options.delay.show),void 0):i.show()},e.prototype.leave=function(e){var i=e instanceof this.constructor?e:t(e.currentTarget)[this.type](this.getDelegateOptions()).data("bs."+this.type);return clearTimeout(i.timeout),i.options.delay&&i.options.delay.hide?(i.hoverState="out",i.timeout=setTimeout(function(){"out"==i.hoverState&&i.hide()},i.options.delay.hide),void 0):i.hide()},e.prototype.show=function(){var e=t.Event("show.bs."+this.type);if(this.hasContent()&&this.enabled){if(this.$element.trigger(e),e.isDefaultPrevented())return;var i=this.tip();this.setContent(),this.options.animation&&i.addClass("fade");var n="function"==typeof this.options.placement?this.options.placement.call(this,i[0],this.$element[0]):this.options.placement,s=/\s?auto?\s?/i,o=s.test(n);o&&(n=n.replace(s,"")||"top"),i.detach().css({top:0,left:0,display:"block"}).addClass(n),this.options.container?i.appendTo(this.options.container):i.insertAfter(this.$element);var a=this.getPosition(),r=i[0].offsetWidth,l=i[0].offsetHeight;if(o){var h=this.$element.parent(),c=n,u=document.documentElement.scrollTop||document.body.scrollTop,d="body"==this.options.container?window.innerWidth:h.outerWidth(),p="body"==this.options.container?window.innerHeight:h.outerHeight(),f="body"==this.options.container?0:h.offset().left;n="bottom"==n&&a.top+a.height+l-u>p?"top":"top"==n&&a.top-u-l<0?"bottom":"right"==n&&a.right+r>d?"left":"left"==n&&a.left-r<f?"right":n,i.removeClass(c).addClass(n)}var m=this.getCalculatedOffset(n,a,r,l);this.applyPlacement(m,n),this.$element.trigger("shown.bs."+this.type)}},e.prototype.applyPlacement=function(t,e){var i,n=this.tip(),s=n[0].offsetWidth,o=n[0].offsetHeight,a=parseInt(n.css("margin-top"),10),r=parseInt(n.css("margin-left"),10);isNaN(a)&&(a=0),isNaN(r)&&(r=0),t.top=t.top+a,t.left=t.left+r,n.offset(t).addClass("in");var l=n[0].offsetWidth,h=n[0].offsetHeight;if("top"==e&&h!=o&&(i=!0,t.top=t.top+o-h),/bottom|top/.test(e)){var c=0;t.left<0&&(c=-2*t.left,t.left=0,n.offset(t),l=n[0].offsetWidth,h=n[0].offsetHeight),this.replaceArrow(c-s+l,l,"left")}else this.replaceArrow(h-o,h,"top");i&&n.offset(t)},e.prototype.replaceArrow=function(t,e,i){this.arrow().css(i,t?50*(1-t/e)+"%":"")},e.prototype.setContent=function(){var t=this.tip(),e=this.getTitle();t.find(".tooltip-inner")[this.options.html?"html":"text"](e),t.removeClass("fade in top bottom left right")},e.prototype.hide=function(){function e(){i.detach()}var i=this.tip(),n=t.Event("hide.bs."+this.type);return this.$element.trigger(n),n.isDefaultPrevented()?void 0:(i.removeClass("in"),t.support.transition&&this.$tip.hasClass("fade")?i.one(t.support.transition.end,e).emulateTransitionEnd(150):e(),this.$element.trigger("hidden.bs."+this.type),this)},e.prototype.fixTitle=function(){var t=this.$element;(t.attr("title")||"string"!=typeof t.attr("data-original-title"))&&t.attr("data-original-title",t.attr("title")||"").attr("title","")},e.prototype.hasContent=function(){return this.getTitle()},e.prototype.getPosition=function(){var e=this.$element[0];return t.extend({},"function"==typeof e.getBoundingClientRect?e.getBoundingClientRect():{width:e.offsetWidth,height:e.offsetHeight},this.$element.offset())},e.prototype.getCalculatedOffset=function(t,e,i,n){return"bottom"==t?{top:e.top+e.height,left:e.left+e.width/2-i/2}:"top"==t?{top:e.top-n,left:e.left+e.width/2-i/2}:"left"==t?{top:e.top+e.height/2-n/2,left:e.left-i}:{top:e.top+e.height/2-n/2,left:e.left+e.width}},e.prototype.getTitle=function(){var t,e=this.$element,i=this.options;return t=e.attr("data-original-title")||("function"==typeof i.title?i.title.call(e[0]):i.title)},e.prototype.tip=function(){return this.$tip=this.$tip||t(this.options.template)},e.prototype.arrow=function(){return this.$arrow=this.$arrow||this.tip().find(".tooltip-arrow")},e.prototype.validate=function(){this.$element[0].parentNode||(this.hide(),this.$element=null,this.options=null)},e.prototype.enable=function(){this.enabled=!0},e.prototype.disable=function(){this.enabled=!1},e.prototype.toggleEnabled=function(){this.enabled=!this.enabled},e.prototype.toggle=function(e){var i=e?t(e.currentTarget)[this.type](this.getDelegateOptions()).data("bs."+this.type):this;i.tip().hasClass("in")?i.leave(i):i.enter(i)},e.prototype.destroy=function(){this.hide().$element.off("."+this.type).removeData("bs."+this.type)};var i=t.fn.tooltip;t.fn.tooltip=function(i){return this.each(function(){var n=t(this),s=n.data("bs.tooltip"),o="object"==typeof i&&i;s||n.data("bs.tooltip",s=new e(this,o)),"string"==typeof i&&s[i]()})},t.fn.tooltip.Constructor=e,t.fn.tooltip.noConflict=function(){return t.fn.tooltip=i,this}}(window.jQuery),/* ========================================================================
 * Bootstrap: popover.js v3.0.0
 * http://twbs.github.com/bootstrap/javascript.html#popovers
 * ========================================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ======================================================================== */
+function(t){"use strict";var e=function(t,e){this.init("popover",t,e)};if(!t.fn.tooltip)throw new Error("Popover requires tooltip.js");e.DEFAULTS=t.extend({},t.fn.tooltip.Constructor.DEFAULTS,{placement:"right",trigger:"click",content:"",template:'<div class="popover"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>'}),e.prototype=t.extend({},t.fn.tooltip.Constructor.prototype),e.prototype.constructor=e,e.prototype.getDefaults=function(){return e.DEFAULTS},e.prototype.setContent=function(){var t=this.tip(),e=this.getTitle(),i=this.getContent();t.find(".popover-title")[this.options.html?"html":"text"](e),t.find(".popover-content")[this.options.html?"html":"text"](i),t.removeClass("fade top bottom left right in"),t.find(".popover-title").html()||t.find(".popover-title").hide()},e.prototype.hasContent=function(){return this.getTitle()||this.getContent()},e.prototype.getContent=function(){var t=this.$element,e=this.options;return t.attr("data-content")||("function"==typeof e.content?e.content.call(t[0]):e.content)},e.prototype.arrow=function(){return this.$arrow=this.$arrow||this.tip().find(".arrow")},e.prototype.tip=function(){return this.$tip||(this.$tip=t(this.options.template)),this.$tip};var i=t.fn.popover;t.fn.popover=function(i){return this.each(function(){var n=t(this),s=n.data("bs.popover"),o="object"==typeof i&&i;s||n.data("bs.popover",s=new e(this,o)),"string"==typeof i&&s[i]()})},t.fn.popover.Constructor=e,t.fn.popover.noConflict=function(){return t.fn.popover=i,this}}(window.jQuery),/* ========================================================================
 * Bootstrap: scrollspy.js v3.0.0
 * http://twbs.github.com/bootstrap/javascript.html#scrollspy
 * ========================================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ======================================================================== */
+function(t){"use strict";function e(i,n){var s,o=t.proxy(this.process,this);this.$element=t(i).is("body")?t(window):t(i),this.$body=t("body"),this.$scrollElement=this.$element.on("scroll.bs.scroll-spy.data-api",o),this.options=t.extend({},e.DEFAULTS,n),this.selector=(this.options.target||(s=t(i).attr("href"))&&s.replace(/.*(?=#[^\s]+$)/,"")||"")+" .nav li > a",this.offsets=t([]),this.targets=t([]),this.activeTarget=null,this.refresh(),this.process()}e.DEFAULTS={offset:10},e.prototype.refresh=function(){var e=this.$element[0]==window?"offset":"position";this.offsets=t([]),this.targets=t([]);var i=this;this.$body.find(this.selector).map(function(){var n=t(this),s=n.data("target")||n.attr("href"),o=/^#\w/.test(s)&&t(s);return o&&o.length&&[[o[e]().top+(!t.isWindow(i.$scrollElement.get(0))&&i.$scrollElement.scrollTop()),s]]||null}).sort(function(t,e){return t[0]-e[0]}).each(function(){i.offsets.push(this[0]),i.targets.push(this[1])})},e.prototype.process=function(){var t,e=this.$scrollElement.scrollTop()+this.options.offset,i=this.$scrollElement[0].scrollHeight||this.$body[0].scrollHeight,n=i-this.$scrollElement.height(),s=this.offsets,o=this.targets,a=this.activeTarget;if(e>=n)return a!=(t=o.last()[0])&&this.activate(t);for(t=s.length;t--;)a!=o[t]&&e>=s[t]&&(!s[t+1]||e<=s[t+1])&&this.activate(o[t])},e.prototype.activate=function(e){this.activeTarget=e,t(this.selector).parents(".active").removeClass("active");var i=this.selector+'[data-target="'+e+'"],'+this.selector+'[href="'+e+'"]',n=t(i).parents("li").addClass("active");n.parent(".dropdown-menu").length&&(n=n.closest("li.dropdown").addClass("active")),n.trigger("activate")};var i=t.fn.scrollspy;t.fn.scrollspy=function(i){return this.each(function(){var n=t(this),s=n.data("bs.scrollspy"),o="object"==typeof i&&i;s||n.data("bs.scrollspy",s=new e(this,o)),"string"==typeof i&&s[i]()})},t.fn.scrollspy.Constructor=e,t.fn.scrollspy.noConflict=function(){return t.fn.scrollspy=i,this},t(window).on("load",function(){t('[data-spy="scroll"]').each(function(){var e=t(this);e.scrollspy(e.data())})})}(window.jQuery),/* ========================================================================
 * Bootstrap: tab.js v3.0.0
 * http://twbs.github.com/bootstrap/javascript.html#tabs
 * ========================================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ======================================================================== */
+function(t){"use strict";var e=function(e){this.element=t(e)};e.prototype.show=function(){var e=this.element,i=e.closest("ul:not(.dropdown-menu)"),n=e.attr("data-target");if(n||(n=e.attr("href"),n=n&&n.replace(/.*(?=#[^\s]*$)/,"")),!e.parent("li").hasClass("active")){var s=i.find(".active:last a")[0],o=t.Event("show.bs.tab",{relatedTarget:s});if(e.trigger(o),!o.isDefaultPrevented()){var a=t(n);this.activate(e.parent("li"),i),this.activate(a,a.parent(),function(){e.trigger({type:"shown.bs.tab",relatedTarget:s})})}}},e.prototype.activate=function(e,i,n){function s(){o.removeClass("active").find("> .dropdown-menu > .active").removeClass("active"),e.addClass("active"),a?(e[0].offsetWidth,e.addClass("in")):e.removeClass("fade"),e.parent(".dropdown-menu")&&e.closest("li.dropdown").addClass("active"),n&&n()}var o=i.find("> .active"),a=n&&t.support.transition&&o.hasClass("fade");a?o.one(t.support.transition.end,s).emulateTransitionEnd(150):s(),o.removeClass("in")};var i=t.fn.tab;t.fn.tab=function(i){return this.each(function(){var n=t(this),s=n.data("bs.tab");s||n.data("bs.tab",s=new e(this)),"string"==typeof i&&s[i]()})},t.fn.tab.Constructor=e,t.fn.tab.noConflict=function(){return t.fn.tab=i,this},t(document).on("click.bs.tab.data-api",'[data-toggle="tab"], [data-toggle="pill"]',function(e){e.preventDefault(),t(this).tab("show")})}(window.jQuery),/* ========================================================================
 * Bootstrap: affix.js v3.0.0
 * http://twbs.github.com/bootstrap/javascript.html#affix
 * ========================================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ======================================================================== */
+function(t){"use strict";var e=function(i,n){this.options=t.extend({},e.DEFAULTS,n),this.$window=t(window).on("scroll.bs.affix.data-api",t.proxy(this.checkPosition,this)).on("click.bs.affix.data-api",t.proxy(this.checkPositionWithEventLoop,this)),this.$element=t(i),this.affixed=this.unpin=null,this.checkPosition()};e.RESET="affix affix-top affix-bottom",e.DEFAULTS={offset:0},e.prototype.checkPositionWithEventLoop=function(){setTimeout(t.proxy(this.checkPosition,this),1)},e.prototype.checkPosition=function(){if(this.$element.is(":visible")){var i=t(document).height(),n=this.$window.scrollTop(),s=this.$element.offset(),o=this.options.offset,a=o.top,r=o.bottom;"object"!=typeof o&&(r=a=o),"function"==typeof a&&(a=o.top()),"function"==typeof r&&(r=o.bottom());var l=null!=this.unpin&&n+this.unpin<=s.top?!1:null!=r&&s.top+this.$element.height()>=i-r?"bottom":null!=a&&a>=n?"top":!1;this.affixed!==l&&(this.unpin&&this.$element.css("top",""),this.affixed=l,this.unpin="bottom"==l?s.top-n:null,this.$element.removeClass(e.RESET).addClass("affix"+(l?"-"+l:"")),"bottom"==l&&this.$element.offset({top:document.body.offsetHeight-r-this.$element.height()}))}};var i=t.fn.affix;t.fn.affix=function(i){return this.each(function(){var n=t(this),s=n.data("bs.affix"),o="object"==typeof i&&i;s||n.data("bs.affix",s=new e(this,o)),"string"==typeof i&&s[i]()})},t.fn.affix.Constructor=e,t.fn.affix.noConflict=function(){return t.fn.affix=i,this},t(window).on("load",function(){t('[data-spy="affix"]').each(function(){var e=t(this),i=e.data();i.offset=i.offset||{},i.offsetBottom&&(i.offset.bottom=i.offsetBottom),i.offsetTop&&(i.offset.top=i.offsetTop),e.affix(i)})})}(window.jQuery);