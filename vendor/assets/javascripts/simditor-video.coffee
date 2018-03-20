class Simditor.VideoButton extends Simditor.Button
  name: 'video'

  icon: 'video'

  title: '插入视频'

  htmlTag: 'video'

  disableTag: 'pre, table'

  _init: (args...) ->
    super args...
    if @editor.formatter._allowedAttributes.video == undefined
      @editor.formatter._allowedAttributes.video = []
    @editor.formatter._allowedAttributes.video.push('src', 'controls')

    @editor.body.on 'click', 'video', (e) =>
      $video = $(e.currentTarget)
      range = document.createRange()
      range.selectNode $video[0]
      @editor.selection.range range
      @popover.show $video

      false

  render: (args...) ->
    super args...
    @popover = new Simditor.VideoPopover
      button: @

  command: ->
    range = @editor.selection.range()
    @editor.selection.range range
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
    $newBlock = $('<p/>').append($video).append($('<br/>'))
    range.insertNode $newBlock[0]
    @editor.selection.setRangeAfter $video, range
    @editor.trigger 'valuechanged'
    $video.click()

class Simditor.VideoPopover extends Simditor.Popover

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

    @srcEl.on 'keydown', (e) =>
      if e.which == 13 or e.which == 27
        e.preventDefault()
        range = document.createRange()
        @editor.selection.setRangeAfter @target, range
        @hide()
        @editor.inputManager.throttledValueChanged()

    @srcEl.on 'blur', => @hide()
  show: (args...) ->
    super args...
    @srcEl.val @target.attr('src')
    @srcEl.focus()

Simditor.Toolbar.addButton Simditor.VideoButton