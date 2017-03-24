$ ->
  $("select.ajax_change_status").on("change", (e) ->
    this_select = $(this)
    before_val = this_select.data('before-val')
    after_val  = this_select.val()
    $.ajax
      url: "/admin/races/#{this_select.data('id')}/change_status"
      type: "PUT"
      data:
        status : after_val
      success: (res) ->
        alert('修改成功')
        this_select.data('before-val', after_val)
#        this_select.find("option[value='#{after_val}']").attr("selected", true);
      error: (res) ->
        alert('修改失败')
        this_select.find("option").removeAttr("selected")
        this_select.find("option[value='#{before_val}']").attr("selected", true);
  );
