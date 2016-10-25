class Validate

  successTagWrapper: ($wrapper) ->
    $wrapper.find(".form-group").each ->
      $(this).removeClass("has-error")
      $(this).find(".help-block.has-error").remove()

  errorTag: ($el, text) ->
    $formGroup = $el.closest(".form-group")

    if $formGroup.find(".help-block.has-error").length == 0
      $formGroup.addClass("has-error")
      $formGroup.append("<span class='help-block has-error'>" + text + "</span>")

  successTag: ($el) ->
    $el.closest(".form-group").removeClass("has-error")
    $el.closest(".form-group").find(".help-block.has-error").remove()    

window.Validate = Validate
