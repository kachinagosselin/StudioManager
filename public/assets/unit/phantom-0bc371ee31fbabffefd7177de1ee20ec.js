/*
 * grunt-contrib-qunit
 * http://gruntjs.com/
 *
 * Copyright (c) 2013 "Cowboy" Ben Alman, contributors
 * Licensed under the MIT license.
 */
!function(){"use strict";function t(){var t=[].slice.call(arguments);alert(JSON.stringify(t))}QUnit.config.reorder=!1,QUnit.config.autorun=!1,QUnit.log=function(e){if("[object Object], undefined:undefined"!==e.message){var n=QUnit.jsDump.parse(e.actual),i=QUnit.jsDump.parse(e.expected);t("qunit.log",e.result,n,i,e.message,e.source)}},QUnit.testStart=function(e){t("qunit.testStart",e.name)},QUnit.testDone=function(e){t("qunit.testDone",e.name,e.failed,e.passed,e.total)},QUnit.moduleStart=function(e){t("qunit.moduleStart",e.name)},QUnit.begin=function(){t("qunit.begin"),console.log("Starting test suite"),console.log("================================================\n")},QUnit.moduleDone=function(e){0===e.failed?console.log("\r✔ All tests passed in '"+e.name+"' module"):console.log("✖ "+e.failed+" tests failed in '"+e.name+"' module"),t("qunit.moduleDone",e.name,e.failed,e.passed,e.total)},QUnit.done=function(e){console.log("\n================================================"),console.log("Tests completed in "+e.runtime+" milliseconds"),console.log(e.passed+" tests of "+e.total+" passed, "+e.failed+" failed."),t("qunit.done",e.failed,e.passed,e.total,e.runtime)}}();