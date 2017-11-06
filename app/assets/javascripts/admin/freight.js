$(function(){
    $("input[type='radio']").bind('change', function(){
        var id = this.value;
        new_url = document.URL.replace(/\/\d+$/,'\/' + id);
        history.pushState(null,null,new_url);
        $.ajax({
            url: "/admin/freights/"+id+"/change_view",
            type: "POST"
        });
    });
});
