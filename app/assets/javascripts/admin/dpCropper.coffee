$ ->
  window.DpCropper =
    call: (source, cropbox, options = {}) ->
      @sourceChangeShowImg(source, cropbox, options)

    sourceChangeShowImg: (source, cropbox, options) ->
      that = @
      source.change ->
        reader = new FileReader()
        reader.onload = (e) ->
          cropbox.attr('src', e.target.result)
          that.toCropbox(cropbox, options)
        reader.readAsDataURL(this.files[0])

    toCropbox: (cropbox, options = {}) ->
      DpCropper.jcropApi.destroy() if DpCropper.cropper
      default_options = {
        boxWidth: 600
        bgOpacity: .2
        setSelect: [0, 0, 300]
        onSelect: @updateCoords
        onChange: @updateCoords
      }
      DpCropper.cropper = cropbox.Jcrop(
        $.extend({}, default_options, options),
        -> DpCropper.jcropApi = this
      )

    updateCoords: (coords) ->
      $('#crop_x').val(coords.x)
      $('#crop_y').val(coords.y)
      $('#crop_w').val(coords.w)
      $('#crop_h').val(coords.h)
