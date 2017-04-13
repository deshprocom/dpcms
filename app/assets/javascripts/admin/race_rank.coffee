$ ->
  console.log($('#search_player_form'))
  $('#search_player_form').on('ajax:success', (e) ->
    alert('d')
    console.log('d')
  );

  if $('.admin_race_ranks').length > 0 && $('.blank_slate').length > 0
    $('.blank_slate').find('a').attr('data-remote', true)
