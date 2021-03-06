# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

  # $(".best_in_place").best_in_place();
  $(".content").click ->
    $(this).toggle()
    $(this).siblings("form").toggle()
    $(this).find('textarea').focus()
    # textarea = "<textarea style='width: #{content.width() - 12}px; height: #{content.height()}px;'>"
    # textarea += content.text()
    # textarea += "</textarea>"
    # content.html(textarea)
    
 
  $(".tag").draggable
    revert: true
    
  $("#trash").droppable
    drop: (event, ui) ->
      tagId = ui.draggable.parent().attr('id').substr(3)
      url = "/tags/" + tagId
      hoverClass: "full_trash"
      $.ajax
        url: url
        type: 'DELETE'
        error: (jqXHR, textStatus, errorThrown) ->
          alert textStatus
        success: (data, textStatus, jqXHR) ->
          $("#tag" + tagId).remove()
          window.location.replace('/')
      
  $("#trash").droppable("option", "hoverClass", "full_trash")

  $(".note").droppable
    activeClass: "ui-state-default"
    hoverClass: "ui-state-hover"
    drop: (event, ui) ->
      tagId = ui.draggable.parent().attr('id').substr(3)
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
      
