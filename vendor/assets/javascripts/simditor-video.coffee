class VideoButton extends Simditor.Button
  name: 'video'

  icon: 'video'

  title: '插入视频'

  htmlTag: 'video'

  disableTag: 'pre, table'

  render: (args...) ->
    super args...
    @popover = new VideoPopover
      button: @

  command: ->
    range = @editor.selection.range()
#    if @editor.selection.blockNodes().length > 0
#      range.insertNode video[0]  # 在当前行后面增加元素
#    else
#      $newBlock = $('<p/>').append(video)
#      range.insertNode $newBlock[0] #新建一行后增加元素

    $video = $('<video/>', {
      src: '',
      controls: 'controls',
      preload: 'none',
      style: 'width: 60%;'
    })
    $newBlock = $('<p/>').append($video)
    range.insertNode $newBlock[0]
    range.selectNodeContents $video[0]

    @popover.one 'popovershow', =>
      @popover.srcEl.focus()
      @popover.srcEl[0].select()

    $video.on 'click', => @popover.show $video

    $video.click()
    @editor.selection.range range
    @editor.trigger 'valuechanged'



class VideoPopover extends Simditor.Popover

  render: ->
    tpl = """
    <div class="video-settings">
      <div class="settings-field">
        <label>视频链接</label>
        <input class="video-src" type="text"/>
      </div>
    </div>
    """
    @el.addClass('video-popover')
      .append(tpl)
    @srcEl = @el.find '.video-src'

    @srcEl.on 'keyup', (e) =>
      return if e.which == 13
      @target.attr('src', @srcEl.val())
      @editor.inputManager.throttledValueChanged()

    $(@srcEl[0]).on 'keydown', (e) =>
      if e.which == 13 or e.which == 27
        e.preventDefault()
        range = document.createRange()
        @editor.selection.setRangeAfter @target, range
        @hide()
        @editor.inputManager.throttledValueChanged()

  show: (args...) ->
    super args...
    @srcEl.val @target.attr('src')

Simditor.Toolbar.addButton VideoButton