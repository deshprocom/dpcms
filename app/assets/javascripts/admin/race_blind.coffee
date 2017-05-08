$ ->
  window.SwtichBlindTypeInputs =
    call: ->
      @init_display()
      @bindSwitch()

    init_display: ->
      type = $("#race_blind_blind_type").val()
      @swith_display(type)

    bindSwitch: ->
      that = @
      $("select#race_blind_blind_type").on "change", (e) ->
        that.swith_display(this.value)

    swith_display: (type) ->
      if type == 'content'
        $('.struct_inputs').hide()
        $('.content_inputs').show()
      else
        $('.content_inputs').hide()
        $('.struct_inputs').show()

