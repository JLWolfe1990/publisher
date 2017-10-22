$(document).ready(function() {
  function buildCommentAfter(element) {
    this.path = element.data('path');
    this.nested = !!element.data('nested');
    this.element = element;

    $.ajax({
      method: 'GET',
      url: path,
      success: function(response) {
        this.element.after(response);
        $(window).scrollTop($('#new-comment').offset().top);
      }.bind(this)
    });
  }

  function articleBlockOnClick(event) {
    event.stopPropagation();

    if ($('#new-comment').length > 0) {
      return false;
    }

    buildCommentAfter($(event.currentTarget.closest('.clickable.comment')))
  }

  _.each($('.comment.clickable'), function(el) {
    el.onclick = articleBlockOnClick;
  });
});