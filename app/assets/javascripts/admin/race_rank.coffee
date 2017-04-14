$ ->
  if $('.admin_race_ranks').length > 0 && $('.blank_slate').length > 0
    $('.blank_slate').find('a').attr('data-remote', true)

  window.SearchPlayer =
    bindEents: ->
      @bindSuccessCallback();
      @bindSelected();

    bindSuccessCallback: ->
      that = @
      $('.search_player_form').on 'ajax:success', (e, data) ->
        $('.players tbody tr').remove();
        $(that.createTrs(data)).appendTo('.players tbody')
        that.bindSelected()

    bindSelected: ->
      $('.players tr button').on 'click', (e) ->
        id = $(@).closest("tr").data('id')
        name = $(@).closest("tr").data('name')
        $('#race_rank_player_id').val(id)
        $('#search_player_input input').val(name)
        $(@).closest(".ui-dialog").find('.ui-dialog-titlebar-close').click();

    createTrs: (ranks) ->
      trs = ''
      for rank in ranks
        trs += "<tr data-id=#{rank.id} data-name=#{rank.name}>"
        trs += "<td>#{rank.player_id}</td>"
        trs += "<td>#{rank.name}</td>"
        trs += "<td>#{rank.country}</td>"
        trs += '<td><button>选择</button></td>'
        trs += '/<tr>'
      trs
