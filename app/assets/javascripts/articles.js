$(document).ready(function() {
  function articleBlockOnClick() {
    window.location = $(this).attr('show-path');
  }

  _.each($('.article-block'), function(el) {
    el.onclick = articleBlockOnClick;
  });
});