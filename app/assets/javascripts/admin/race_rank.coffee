$ ->
  if $('.admin_race_ranks').length > 0 && $('.blank_slate').length > 0
    $('.blank_slate').find('a').attr('data-remote', true)
