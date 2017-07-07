$ ->
  window.dpEditor =
    call: (textarea, form, options = {}) ->
      editor = @new(textarea, options)
      form.submit ->
        fillValue = toMarkdown(editor.getValue(), { gfm: true })
        editor.textarea.val(fillValue)

    new: (textarea, options) ->
      val = textarea.val()
      textarea.val(marked(val))
      placeholder = if options['placeholder'] then options['placeholder'] else '这里输入文字...'
      new Simditor(
        textarea: textarea,
        toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough' ,'hr', '|', 'ol', 'ul', 'blockquote', 'link','image', '|', 'markdown'],
        toolbarFloat: false,
        placeholder: placeholder,
        pasteImage: true,
        upload: {
          url: '/photos',
          fileKey: 'image',
          leaveConfirm: '正在上传文件，如果离开上传会自动取消'
        }
      )
