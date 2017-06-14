$ ->
  if $('.admin_race_blinds').length > 0 && $('.blank_slate').length > 0
    $('.blank_slate').find('a').attr('data-remote', true)

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
      if type == 'blind_content'
        $('.struct_inputs').hide()
        $('.content_inputs').show()
      else
        $('.content_inputs').hide()
        $('.struct_inputs').show()

