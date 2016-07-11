# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@check_suppressions=->
  $('input#message_email').focusout ->
    email_to = $("#message_email").val()
    data =
      email: email_to
    $.ajax
      url: '/messages/detect_suppressions'
      data: data
    return