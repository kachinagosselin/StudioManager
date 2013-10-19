/**
 * QUnit - A JavaScript Unit Testing Framework
 *
 * http://docs.jquery.com/QUnit
 *
 * Copyright (c) 2012 John Resig, Jörn Zaefferer
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * or GPL (GPL-LICENSE.txt) licenses.
 */
!function(e){function t(){w.autorun=!0,w.currentModule&&y.moduleDone({name:w.currentModule,failed:w.moduleStats.bad,passed:w.moduleStats.all-w.moduleStats.bad,total:w.moduleStats.all});var e=p("qunit-banner"),t=p("qunit-tests"),n=+new Date-w.started,r=w.stats.all-w.stats.bad,s=["Tests completed in ",n," milliseconds.<br/>",'<span class="passed">',r,'</span> tests of <span class="total">',w.stats.all,'</span> passed, <span class="failed">',w.stats.bad,"</span> failed."].join("");e&&(e.className=w.stats.bad?"qunit-fail":"qunit-pass"),t&&(p("qunit-testresult").innerHTML=s),w.altertitle&&"undefined"!=typeof document&&document.title&&(document.title=[w.stats.bad?"✖":"✔",document.title.replace(/^[\u2714\u2716] /i,"")].join(" ")),y.done({failed:w.stats.bad,passed:r,total:w.stats.all,runtime:n})}function n(e){var t=w.filter,n=!1;if(!t)return!0;var r="!"===t.charAt(0);return r&&(t=t.slice(1)),-1!==e.indexOf(t)?!r:(r&&(n=!0),n)}function r(){try{throw new Error}catch(e){if(e.stacktrace)return e.stacktrace.split("\n")[6];if(e.stack)return e.stack.split("\n")[4];e.sourceURL}}function s(e){return e?(e+="",e.replace(/[\&"<>\\]/g,function(e){switch(e){case"&":return"&amp;";case"\\":return"\\\\";case'"':return'"';case"<":return"&lt;";case">":return"&gt;";default:return e}})):""}function o(e){w.queue.push(e),w.autorun&&!w.blocking&&i()}function i(){for(var n=(new Date).getTime();w.queue.length&&!w.blocking;){if(!(w.updateRate<=0||(new Date).getTime()-n<w.updateRate)){e.setTimeout(i,13);break}w.queue.shift()()}w.blocking||w.queue.length||t()}function a(){if(w.pollution=[],w.noglobals)for(var t in e)w.pollution.push(t)}function u(){var e=w.pollution;a();var t=l(w.pollution,e);t.length>0&&ok(!1,"Introduced global variable(s): "+t.join(", "));var n=l(e,w.pollution);n.length>0&&ok(!1,"Deleted global variable(s): "+n.join(", "))}function l(e,t){for(var n=e.slice(),r=0;r<n.length;r++)for(var s=0;s<t.length;s++)if(n[r]===t[s]){n.splice(r,1),r--;break}return n}function c(t,n,r){"undefined"!=typeof console&&console.error&&console.warn?(console.error(t),console.error(n),console.warn(r.toString())):e.opera&&opera.postError&&opera.postError(t,n,r.toString)}function d(e,t){for(var n in t)void 0===t[n]?delete e[n]:e[n]=t[n];return e}function f(e,t,n){e.addEventListener?e.addEventListener(t,n,!1):e.attachEvent?e.attachEvent("on"+t,n):n()}function p(e){return!("undefined"==typeof document||!document||!document.getElementById)&&document.getElementById(e)}function m(e){for(var t,n="",r=0;e[r];r++)t=e[r],3===t.nodeType||4===t.nodeType?n+=t.nodeValue:8!==t.nodeType&&(n+=m(t.childNodes));return n}function h(e,t){if(t.indexOf)return t.indexOf(e);for(var n=0,r=t.length;r>n;n++)if(t[n]===e)return n;return-1}var g={setTimeout:"undefined"!=typeof e.setTimeout,sessionStorage:function(){try{return!!sessionStorage.getItem}catch(e){return!1}}()},v=0,b=function(e,t,n,r,s,o){this.name=e,this.testName=t,this.expected=n,this.testEnvironmentArg=r,this.async=s,this.callback=o,this.assertions=[]};b.prototype={init:function(){var e=p("qunit-tests");if(e){var t=document.createElement("strong");t.innerHTML="Running "+this.name;var n=document.createElement("li");n.appendChild(t),n.className="running",n.id=this.id="test-output"+v++,e.appendChild(n)}},setup:function(){this.module!=w.previousModule&&(w.previousModule&&y.moduleDone({name:w.previousModule,failed:w.moduleStats.bad,passed:w.moduleStats.all-w.moduleStats.bad,total:w.moduleStats.all}),w.previousModule=this.module,w.moduleStats={all:0,bad:0},y.moduleStart({name:this.module})),w.current=this,this.testEnvironment=d({setup:function(){},teardown:function(){}},this.moduleTestEnvironment),this.testEnvironmentArg&&d(this.testEnvironment,this.testEnvironmentArg),y.testStart({name:this.testName}),y.current_testEnvironment=this.testEnvironment;try{w.pollution||a(),this.testEnvironment.setup.call(this.testEnvironment)}catch(e){y.ok(!1,"Setup failed on "+this.testName+": "+e.message)}},run:function(){if(this.async&&y.stop(),w.notrycatch)return this.callback.call(this.testEnvironment),void 0;try{this.callback.call(this.testEnvironment)}catch(e){c("Test "+this.testName+" died, exception and test follows",e,this.callback),y.ok(!1,"Died on test #"+(this.assertions.length+1)+": "+e.message+" - "+y.jsDump.parse(e)),a(),w.blocking&&start()}},teardown:function(){try{this.testEnvironment.teardown.call(this.testEnvironment),u()}catch(e){y.ok(!1,"Teardown failed on "+this.testName+": "+e.message)}},finish:function(){this.expected&&this.expected!=this.assertions.length&&y.ok(!1,"Expected "+this.expected+" assertions, but "+this.assertions.length+" were run");var t=0,n=0,r=p("qunit-tests");if(w.stats.all+=this.assertions.length,w.moduleStats.all+=this.assertions.length,r){for(var s=document.createElement("ol"),o=0;o<this.assertions.length;o++){var i=this.assertions[o],a=document.createElement("li");a.className=i.result?"pass":"fail",a.innerHTML=i.message||(i.result?"okay":"failed"),s.appendChild(a),i.result?t++:(n++,w.stats.bad++,w.moduleStats.bad++)}y.config.reorder&&g.sessionStorage&&(n?sessionStorage.setItem("qunit-"+this.module+"-"+this.testName,n):sessionStorage.removeItem("qunit-"+this.module+"-"+this.testName)),0==n&&(s.style.display="none");var u=document.createElement("strong");u.innerHTML=this.name+" <b class='counts'>(<b class='failed'>"+n+"</b>, <b class='passed'>"+t+"</b>, "+this.assertions.length+")</b>";var l=document.createElement("a");l.innerHTML="Rerun",l.href=y.url({filter:m([u]).replace(/\([^)]+\)$/,"").replace(/(^\s*|\s*$)/g,"")}),f(u,"click",function(){var e=u.nextSibling.nextSibling,t=e.style.display;e.style.display="none"===t?"block":"none"}),f(u,"dblclick",function(t){var n=t&&t.target?t.target:e.event.srcElement;("span"==n.nodeName.toLowerCase()||"b"==n.nodeName.toLowerCase())&&(n=n.parentNode),e.location&&"strong"===n.nodeName.toLowerCase()&&(e.location=y.url({filter:m([n]).replace(/\([^)]+\)$/,"").replace(/(^\s*|\s*$)/g,"")}))});var a=p(this.id);a.className=n?"fail":"pass",a.removeChild(a.firstChild),a.appendChild(u),a.appendChild(l),a.appendChild(s)}else for(var o=0;o<this.assertions.length;o++)this.assertions[o].result||(n++,w.stats.bad++,w.moduleStats.bad++);try{y.reset()}catch(d){c("reset() failed, following Test "+this.testName+", exception and reset fn follows",d,y.reset)}y.testDone({name:this.testName,failed:n,passed:this.assertions.length-n,total:this.assertions.length})},queue:function(){function e(){o(function(){t.setup()}),o(function(){t.run()}),o(function(){t.teardown()}),o(function(){t.finish()})}var t=this;o(function(){t.init()});var n=y.config.reorder&&g.sessionStorage&&+sessionStorage.getItem("qunit-"+this.module+"-"+this.testName);n?e():o(e)}};var y={module:function(e,t){w.currentModule=e,w.currentModuleTestEnviroment=t},asyncTest:function(e,t,n){2===arguments.length&&(n=t,t=0),y.test(e,t,n,!0)},test:function(e,t,r,s){var o,i='<span class="test-name">'+e+"</span>";if(2===arguments.length&&(r=t,t=null),t&&"object"==typeof t&&(o=t,t=null),w.currentModule&&(i='<span class="module-name">'+w.currentModule+"</span>: "+i),n(w.currentModule+": "+e)){var a=new b(i,e,t,o,s,r);a.module=w.currentModule,a.moduleTestEnvironment=w.currentModuleTestEnviroment,a.queue()}},expect:function(e){w.current.expected=e},ok:function(e,t){e=!!e;var n={result:e,message:t};t=s(t),y.log(n),w.current.assertions.push({result:e,message:t})},equal:function(e,t,n){y.push(t==e,e,t,n)},notEqual:function(e,t,n){y.push(t!=e,e,t,n)},deepEqual:function(e,t,n){y.push(y.equiv(e,t),e,t,n)},notDeepEqual:function(e,t,n){y.push(!y.equiv(e,t),e,t,n)},strictEqual:function(e,t,n){y.push(t===e,e,t,n)},notStrictEqual:function(e,t,n){y.push(t!==e,e,t,n)},raises:function(e,t,n){var r,s=!1;"string"==typeof t&&(n=t,t=null);try{e()}catch(o){r=o}r&&(t?"regexp"===y.objectType(t)?s=t.test(r):r instanceof t?s=!0:t.call({},r)===!0&&(s=!0):s=!0),y.ok(s,n)},start:function(){w.semaphore--,w.semaphore>0||(w.semaphore<0&&(w.semaphore=0),g.setTimeout?e.setTimeout(function(){w.semaphore>0||(w.timeout&&clearTimeout(w.timeout),w.blocking=!1,i())},13):(w.blocking=!1,i()))},stop:function(t){w.semaphore++,w.blocking=!0,t&&g.setTimeout&&(clearTimeout(w.timeout),w.timeout=e.setTimeout(function(){y.ok(!1,"Test timed out"),y.start()},t))}};y.equals=y.equal,y.same=y.deepEqual;var w={queue:[],blocking:!0,hidepassed:!1,reorder:!0,altertitle:!0,urlConfig:["noglobals","notrycatch"]};!function(){var t,n=e.location||{search:"",protocol:"file:"},r=n.search.slice(1).split("&"),s=r.length,o={};if(r[0])for(var i=0;s>i;i++)t=r[i].split("="),t[0]=decodeURIComponent(t[0]),t[1]=t[1]?decodeURIComponent(t[1]):!0,o[t[0]]=t[1];y.urlParams=o,w.filter=o.filter,y.isLocal=!("file:"!==n.protocol)}(),"undefined"==typeof exports||"undefined"==typeof require?(d(e,y),e.QUnit=y):(d(exports,y),exports.QUnit=y),d(y,{config:w,init:function(){d(w,{stats:{all:0,bad:0},moduleStats:{all:0,bad:0},started:+new Date,updateRate:1e3,blocking:!1,autostart:!0,autorun:!1,filter:"",queue:[],semaphore:0});var e=p("qunit-tests"),t=p("qunit-banner"),n=p("qunit-testresult");e&&(e.innerHTML=""),t&&(t.className=""),n&&n.parentNode.removeChild(n),e&&(n=document.createElement("p"),n.id="qunit-testresult",n.className="result",e.parentNode.insertBefore(n,e),n.innerHTML="Running...<br/>&nbsp;")},reset:function(){if(e.jQuery)jQuery("#qunit-fixture").html(w.fixture);else{var t=p("qunit-fixture");t&&(t.innerHTML=w.fixture)}},triggerEvent:function(e,t,n){document.createEvent?(n=document.createEvent("MouseEvents"),n.initMouseEvent(t,!0,!0,e.ownerDocument.defaultView,0,0,0,0,0,!1,!1,!1,!1,0,null),e.dispatchEvent(n)):e.fireEvent&&e.fireEvent("on"+t)},is:function(e,t){return y.objectType(t)==e},objectType:function(e){if("undefined"==typeof e)return"undefined";if(null===e)return"null";var t=Object.prototype.toString.call(e).match(/^\[object\s(.*)\]$/)[1]||"";switch(t){case"Number":return isNaN(e)?"nan":"number";case"String":case"Boolean":case"Array":case"Date":case"RegExp":case"Function":return t.toLowerCase()}return"object"==typeof e?"object":void 0},push:function(e,t,n,o){var i={result:e,message:o,actual:t,expected:n};o=s(o)||(e?"okay":"failed"),o='<span class="test-message">'+o+"</span>",n=s(y.jsDump.parse(n)),t=s(y.jsDump.parse(t));var a=o+'<table><tr class="test-expected"><th>Expected: </th><td><pre>'+n+"</pre></td></tr>";if(t!=n&&(a+='<tr class="test-actual"><th>Result: </th><td><pre>'+t+"</pre></td></tr>",a+='<tr class="test-diff"><th>Diff: </th><td><pre>'+y.diff(n,t)+"</pre></td></tr>"),!e){var u=r();u&&(i.source=u,a+='<tr class="test-source"><th>Source: </th><td><pre>'+s(u)+"</pre></td></tr>")}a+="</table>",y.log(i),w.current.assertions.push({result:!!e,message:a})},url:function(t){t=d(d({},y.urlParams),t);var n,r="?";for(n in t)r+=encodeURIComponent(n)+"="+encodeURIComponent(t[n])+"&";return e.location.pathname+r.slice(0,-1)},extend:d,id:p,addEvent:f,begin:function(){},done:function(){},log:function(){},testStart:function(){},testDone:function(){},moduleStart:function(){},moduleDone:function(){}}),("undefined"==typeof document||"complete"===document.readyState)&&(w.autorun=!0),y.load=function(){y.begin({});var t=d({},w);y.init(),d(w,t),w.blocking=!1;for(var n,r="",s=(w.urlConfig.length,0);n=w.urlConfig[s];s++)w[n]=y.urlParams[n],r+='<label><input name="'+n+'" type="checkbox"'+(w[n]?' checked="checked"':"")+">"+n+"</label>";var o=p("qunit-userAgent");o&&(o.innerHTML=navigator.userAgent);var i=p("qunit-header");i&&(i.innerHTML='<a href="'+y.url({filter:void 0})+'"> '+i.innerHTML+"</a> "+r,f(i,"change",function(t){var n={};n[t.target.name]=t.target.checked?!0:void 0,e.location=y.url(n)}));var a=p("qunit-testrunner-toolbar");if(a){var u=document.createElement("input");if(u.type="checkbox",u.id="qunit-filter-pass",f(u,"click",function(){var e=document.getElementById("qunit-tests");if(u.checked)e.className=e.className+" hidepass";else{var t=" "+e.className.replace(/[\n\t\r]/g," ")+" ";e.className=t.replace(/ hidepass /," ")}g.sessionStorage&&(u.checked?sessionStorage.setItem("qunit-filter-passed-tests","true"):sessionStorage.removeItem("qunit-filter-passed-tests"))}),w.hidepassed||g.sessionStorage&&sessionStorage.getItem("qunit-filter-passed-tests")){u.checked=!0;var l=document.getElementById("qunit-tests");l.className=l.className+" hidepass"}a.appendChild(u);var c=document.createElement("label");c.setAttribute("for","qunit-filter-pass"),c.innerHTML="Hide passed tests",a.appendChild(c)}var m=p("qunit-fixture");m&&(w.fixture=m.innerHTML),w.autostart&&y.start()},f(e,"load",y.load),y.equiv=function(){function e(e,t,n){var r=y.objectType(e);return r?"function"===y.objectType(t[r])?t[r].apply(t,n):t[r]:void 0}var t,n=[],r=[],s=function(){function e(e,t){return e instanceof t.constructor||t instanceof e.constructor?t==e:t===e}return{string:e,"boolean":e,number:e,"null":e,undefined:e,nan:function(e){return isNaN(e)},date:function(e,t){return"date"===y.objectType(e)&&t.valueOf()===e.valueOf()},regexp:function(e,t){return"regexp"===y.objectType(e)&&t.source===e.source&&t.global===e.global&&t.ignoreCase===e.ignoreCase&&t.multiline===e.multiline},"function":function(){var e=n[n.length-1];return e!==Object&&"undefined"!=typeof e},array:function(e,n){var s,o,i,a;if("array"!==y.objectType(e))return!1;if(a=n.length,a!==e.length)return!1;for(r.push(n),s=0;a>s;s++){for(i=!1,o=0;o<r.length;o++)r[o]===n[s]&&(i=!0);if(!i&&!t(n[s],e[s]))return r.pop(),!1}return r.pop(),!0},object:function(e,s){var o,i,a,u=!0,l=[],c=[];if(s.constructor!==e.constructor)return!1;n.push(s.constructor),r.push(s);for(o in s){for(a=!1,i=0;i<r.length;i++)r[i]===s[o]&&(a=!0);if(l.push(o),!a&&!t(s[o],e[o])){u=!1;break}}n.pop(),r.pop();for(o in e)c.push(o);return u&&t(l.sort(),c.sort())}}}();return t=function(){var t=Array.prototype.slice.apply(arguments);return t.length<2?!0:function(t,n){return t===n?!0:null===t||null===n||"undefined"==typeof t||"undefined"==typeof n||y.objectType(t)!==y.objectType(n)?!1:e(t,s,[n,t])}(t[0],t[1])&&arguments.callee.apply(this,t.splice(1,t.length-1))}}(),/**
 * jsDump Copyright (c) 2008 Ariel Flesler - aflesler(at)gmail(dot)com |
 * http://flesler.blogspot.com Licensed under BSD
 * (http://www.opensource.org/licenses/bsd-license.php) Date: 5/15/2008
 *
 * @projectDescription Advanced and extensible data dumping for Javascript.
 * @version 1.0.0
 * @author Ariel Flesler
 * @link {http://flesler.blogspot.com/2008/05/jsdump-pretty-dump-of-any-javascript.html}
 */
y.jsDump=function(){function e(e){return'"'+e.toString().replace(/"/g,'\\"')+'"'}function t(e){return e+""}function n(e,t,n){var r=o.separator(),s=o.indent(),i=o.indent(1);return t.join&&(t=t.join(","+r+i)),t?[e,i+t,s+n].join(r):e+n}function r(e,t){var r=e.length,s=Array(r);for(this.up();r--;)s[r]=this.parse(e[r],void 0,t);return this.down(),n("[",s,"]")}var s=/^function (\w+)/,o={parse:function(e,t,n){n=n||[];var r=this.parsers[t||this.typeOf(e)];t=typeof r;var s=h(e,n);if(-1!=s)return"recursion("+(s-n.length)+")";if("function"==t){n.push(e);var o=r.call(this,e,n);return n.pop(),o}return"string"==t?r:this.parsers.error},typeOf:function(e){var t;return t=null===e?"null":"undefined"==typeof e?"undefined":y.is("RegExp",e)?"regexp":y.is("Date",e)?"date":y.is("Function",e)?"function":void 0!==typeof e.setInterval&&"undefined"!=typeof e.document&&"undefined"==typeof e.nodeType?"window":9===e.nodeType?"document":e.nodeType?"node":"object"==typeof e&&"number"==typeof e.length&&e.length>=0?"array":typeof e},separator:function(){return this.multiline?this.HTML?"<br />":"\n":this.HTML?"&nbsp;":" "},indent:function(e){if(!this.multiline)return"";var t=this.indentChar;return this.HTML&&(t=t.replace(/\t/g,"   ").replace(/ /g,"&nbsp;")),Array(this._depth_+(e||0)).join(t)},up:function(e){this._depth_+=e||1},down:function(e){this._depth_-=e||1},setParser:function(e,t){this.parsers[e]=t},quote:e,literal:t,join:n,_depth_:1,parsers:{window:"[Window]",document:"[Document]",error:"[ERROR]",unknown:"[Unknown]","null":"null",undefined:"undefined","function":function(e){var t="function",r="name"in e?e.name:(s.exec(e)||[])[1];return r&&(t+=" "+r),t+="(",t=[t,y.jsDump.parse(e,"functionArgs"),"){"].join(""),n(t,y.jsDump.parse(e,"functionCode"),"}")},array:r,nodelist:r,arguments:r,object:function(e,t){var r=[];y.jsDump.up();for(var s in e){var o=e[s];r.push(y.jsDump.parse(s,"key")+": "+y.jsDump.parse(o,void 0,t))}return y.jsDump.down(),n("{",r,"}")},node:function(e){var t=y.jsDump.HTML?"&lt;":"<",n=y.jsDump.HTML?"&gt;":">",r=e.nodeName.toLowerCase(),s=t+r;for(var o in y.jsDump.DOMAttrs){var i=e[y.jsDump.DOMAttrs[o]];i&&(s+=" "+o+"="+y.jsDump.parse(i,"attribute"))}return s+n+t+"/"+r+n},functionArgs:function(e){var t=e.length;if(!t)return"";for(var n=Array(t);t--;)n[t]=String.fromCharCode(97+t);return" "+n.join(", ")+" "},key:e,functionCode:"[code]",attribute:e,string:e,date:e,regexp:t,number:t,"boolean":t},DOMAttrs:{id:"id",name:"name","class":"className"},HTML:!1,indentChar:"  ",multiline:!0};return o}(),y.diff=function(){function e(e,t){for(var n={},r={},s=0;s<t.length;s++)null==n[t[s]]&&(n[t[s]]={rows:[],o:null}),n[t[s]].rows.push(s);for(var s=0;s<e.length;s++)null==r[e[s]]&&(r[e[s]]={rows:[],n:null}),r[e[s]].rows.push(s);for(var s in n)1==n[s].rows.length&&"undefined"!=typeof r[s]&&1==r[s].rows.length&&(t[n[s].rows[0]]={text:t[n[s].rows[0]],row:r[s].rows[0]},e[r[s].rows[0]]={text:e[r[s].rows[0]],row:n[s].rows[0]});for(var s=0;s<t.length-1;s++)null!=t[s].text&&null==t[s+1].text&&t[s].row+1<e.length&&null==e[t[s].row+1].text&&t[s+1]==e[t[s].row+1]&&(t[s+1]={text:t[s+1],row:t[s].row+1},e[t[s].row+1]={text:e[t[s].row+1],row:s+1});for(var s=t.length-1;s>0;s--)null!=t[s].text&&null==t[s-1].text&&t[s].row>0&&null==e[t[s].row-1].text&&t[s-1]==e[t[s].row-1]&&(t[s-1]={text:t[s-1],row:t[s].row-1},e[t[s].row-1]={text:e[t[s].row-1],row:s-1});return{o:e,n:t}}return function(t,n){t=t.replace(/\s+$/,""),n=n.replace(/\s+$/,"");var r=e(""==t?[]:t.split(/\s+/),""==n?[]:n.split(/\s+/)),s="",o=t.match(/\s+/g);null==o?o=[" "]:o.push(" ");var i=n.match(/\s+/g);if(null==i?i=[" "]:i.push(" "),0==r.n.length)for(var a=0;a<r.o.length;a++)s+="<del>"+r.o[a]+o[a]+"</del>";else{if(null==r.n[0].text)for(n=0;n<r.o.length&&null==r.o[n].text;n++)s+="<del>"+r.o[n]+o[n]+"</del>";for(var a=0;a<r.n.length;a++)if(null==r.n[a].text)s+="<ins>"+r.n[a]+i[a]+"</ins>";else{var u="";for(n=r.n[a].row+1;n<r.o.length&&null==r.o[n].text;n++)u+="<del>"+r.o[n]+o[n]+"</del>";s+=" "+r.n[a].text+i[a]+u}}return s}}()}(this);