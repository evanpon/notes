# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $(".tag").draggable
    revert: true
  $(".note").droppable
    activeClass: "ui-state-default"
    hoverClass: "ui-state-hover"
    drop: (event, ui) ->
      tagId = ui.draggable.attr('id').substr(3)
      note = $(this)
      noteId = note.attr('id').substr(4)
      url = "/notes/" + noteId + "/tag"
      $.ajax
        url: url
        type: 'POST'
        dataType: 'json'
        data: {tag_id: tagId}
        error: (jqXHR, textStatus, errorThrown) ->
          alert textStatus
        success: (data, textStatus, jqXHR) ->
          note.find(".tags").html(data.join(', '))
  
  $('textarea').keypress (e) ->
    if (e.ctrlKey && e.keyCode == 13) 
      e.preventDefault()
      $(this).closest('form').submit()
      
#     if (e.ctrlKey && e.keyCode == 13) {
#         $(this).closest('form').find('input[type=submit][name=submit]').click();
#     }
# });
      
