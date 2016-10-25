class MarkEditor

  initialize: ->
    $(".js-MarkEditor:not([style='display: none;'])").wysihtml5
      "font-styles": true
      "emphasis": true
      "lists": true
      "html": false
      "link": true
      "image": false
      "color": false
      "blockquote": true

window.MarkEditor = MarkEditor