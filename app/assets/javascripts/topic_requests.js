$(document).ready(function() {
  function castVote(event) {
    event.stopPropagation();

    var path = $(this).attr('path');

    $.post(path, { article: {} }, function() {
      location.reload();
    })
  }

  function viewTopicRequest() {
    var path = $(this).attr('path');

    $.getJSON(path, function (data) {
      $('#genericModalTitle').html(data.title);
      $('#genericModalBody').html(data.description);

      $('#genericModal').modal({ show: true });
    });
  }

  _.each($('.topic-request-block button'), function(el) {
    el.onclick = castVote;
  });

  _.each($('.topic-request-block'), function(el) {
    el.onclick = viewTopicRequest;
  });
});
