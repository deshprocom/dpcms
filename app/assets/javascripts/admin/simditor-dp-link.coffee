class SimditorDpLink extends Simditor.Button
  
  name: 'dpLink'
  
  icon: 'dpLink'
  
  htmlTag: 'dpLink'
  
  disableTag: 'pre'

  clickToLink: ->

  command: ->
    range = @editor.selection.range()
    $contents = $(range.extractContents())
    linkText = @editor.formatter.clearHtml($contents.contents(), false)
    dp_link = $('<a/>', {
      href: '',
      target: '_blank',
      text: linkText || @_t('linkText')
    })

    if @editor.selection.blockNodes().length > 0
      range.insertNode dp_link[0]
    else
      $newBlock = $('<p/>').append(dp_link)
      range.insertNode $newBlock[0]

#    range.selectNodeContents dp_link[0] # 跳出编辑链接
    @editor.selection.range range
    @editor.trigger 'valuechanged'

    console.log(dp_link)
    dialog = $('.sources').dialog({ width: '50%' })
    dialog.one 'click', 'tbody tr', (e) ->
      id = $(this).data('id')
      dp_link.text($(this).data('title'))
      dp_link.attr('href', id);
      dialog.dialog('close')

Simditor.Toolbar.addButton SimditorDpLink