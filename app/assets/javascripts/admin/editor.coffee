$ ->
  window.dpEditor =
    call: (textarea, form) ->
      editor = @new(textarea)
      form.submit ->
        fillValue = toMarkdown(editor.getValue(), { gfm: true })
        editor.textarea.val(fillValue)

    new: (textarea) ->
      val = textarea.val();
      textarea.val(marked(val));
      new Simditor(
        textarea: textarea,
        toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough' ,'hr', '|', 'ol', 'ul', 'blockquote', 'link','image', '|', 'markdown'],
        placeholder: '这里输入文字...',
        pasteImage: true,
        upload: {
          url: '/photos',
          fileKey: 'image',
          leaveConfirm: '正在上传文件，如果离开上传会自动取消'
        }
      )
