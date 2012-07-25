/*
 Mouseover Opacity 1.0.0 for jQuery
 Copyright (c) 2010-Present, Retromeme Inc. All Rights Reserved.
 http://retromeme.jp
*/

$(function() { var images = $("img"); for(var i=0; i < images.size(); i++) { if(images.eq(i).attr("src").match("btn-")) { $("img").eq(i).hover(function() { $(this).css('opacity', '0.7'); }, function() { $(this).css('opacity', '1'); }); } } });$(function() { var images = $("img"); for(var i=0; i < images.size(); i++) { if(images.eq(i).attr("src").match("_off.")) { $("img").eq(i).hover(function() { $(this).attr('src', $(this).attr("src").replace("_off.", "_on.")); $(this).css('opacity', '1'); }, function() { $(this).attr('src', $(this).attr("src").replace("_on.", "_off.")); }); } } });