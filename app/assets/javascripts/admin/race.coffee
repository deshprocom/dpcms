$ ->
  $("select.ajax_change_status").on("change", (e) ->
    this_select = $(this)
    before_val = this_select.data('before-val')
    after_val  = this_select.val()
    $.ajax
      url: "/admin/races/#{this_select.data('id')}/change_status"
      type: "PUT"
      data:
        status : after_val
      success: (res) ->
        alert('修改成功')
        this_select.data('before-val', after_val)
#        this_select.find("option[value='#{after_val}']").attr("selected", true);
      error: (res) ->
        alert('修改失败')
        this_select.find("option").removeAttr("selected")
        this_select.find("option[value='#{before_val}']").attr("selected", true);
  );

  $(':checkbox#race_describable').click (e) ->
    unless $(this).is(':checked')
      $(':checkbox#race_ticket_sellable')[0].checked = false
      return

  if $('.ticket_number_manage').length > 0
    class shake_ticketing
      constructor: ->
        @ticket_info_id = $('#ticket_info_id').val();
        @shake_font_size = '25px'
        @original_font_size = '16px'
        @start()

      timer: ->
        console.log 'do something'

      setInterval: ->
        setInterval @start, 1000

      test: ->
        return 'test'
      start: ->
        shake_ticketing = @
        $.ajax
          url: "/admin/ticket_infos/" + @ticket_info_id + ".json"
          type: "get"
          success: (res) ->
            console.log(222)
            shake_ticketing.shake_entity_ticket(res)
      shake_e_ticket: ->
        't'

      shake_entity_ticket: (data) ->
        ori_surplus_entity_ticket = $('#surplus_entity_ticket').data('surplus-entity-ticket')
        unless ori_surplus_entity_ticket == data.surplus_entity_ticket
          entity_ticket_text = "共#{data.entity_ticket_number}张，已售#{data.entity_ticket_sold_number}张，剩余#{data.surplus_entity_ticket}"
          $('#surplus_entity_ticket').text(entity_ticket_text)
            .animate({fontSize: @shake_font_size},"fast")
            .animate({fontSize: @original_font_size},"fast")
          $('#surplus_entity_ticket').data('surplus-entity-ticket', data.surplus_entity_ticket)

    new_shake_ticketing = -> new shake_ticketing()
    setInterval(new_shake_ticketing, 1000)

