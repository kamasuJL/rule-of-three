/*global $*/

$(document).ready(function(){
  var maxHeight = 0;
  $(".card-body").each(function(){
    if ($(this).height() > maxHeight) { maxHeight = $(this).height(); }
  });
  $(".card-body").height(maxHeight);
});
