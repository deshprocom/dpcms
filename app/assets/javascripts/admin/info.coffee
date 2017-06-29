$ ->
  $('.common_radio_lang input[type=radio]').click ->
    checked_value = $(".common_radio_lang input[name=info_lang]:checked").val()
    if checked_value == 'yes'
      $('#common_markdown_style_en').hide()
      $('#common_markdown_style_cn').show()
    else
      $('#common_markdown_style_cn').hide()
      $('#common_markdown_style_en').show()