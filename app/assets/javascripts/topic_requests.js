$(document).ready(function() {
  function castVote() {
    var path = $(this).attr('path');

    $.post(path, { article: {} }, function() {
      location.reload();
    })
  }

  _.each($('.topic-request-block button'), function(el) {
    el.onclick = castVote;
  });
});
