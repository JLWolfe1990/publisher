$(document).ready(function() {
  function castVote() {
    var path = $(this).attr('path');

    $.post(path, { article: {} }, function() {
      debugger
      true
    })
  }

  _.each($('.topic-request-block button'), function(el) {
    el.onclick = castVote;
  });
});
