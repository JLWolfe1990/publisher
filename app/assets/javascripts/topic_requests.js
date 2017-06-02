$(document).ready(function() {
  function castVote(event) {
    event.stopPropigation();

    var path = $(this).attr('path');

    $.post(path, { article: {} }, function() {
      location.reload();
    })
  }

  function viewTopicRequest() {
    var path = $(this).attr('path');

    location.href = path;
  }

  _.each($('.topic-request-block button'), function(el) {
    el.onclick = castVote;
  });

  _.each($('.topic-request-block'), function(el) {
    el.onclick = viewTopicRequest;
  });
});
