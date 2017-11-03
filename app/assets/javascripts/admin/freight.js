$(function(){
    $("input[type='radio']").bind('change', function(){
        var id = this.value;
        $.ajax({
            url: "/admin/freights/"+id+"/change_view",
            type: "POST"
        });
    });
});
