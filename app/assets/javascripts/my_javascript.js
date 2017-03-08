$(function(){
    $(".order_price_modified").bind('click', function(){
        $(".change_order_price").show();
        $(".order_price").hide();
        $(".order_price_modified").hide();
    })

    $(".order_button_cancel").bind('click', function(){
        $(".change_order_price").hide();
        $(".order_price").show();
        $(".order_price_modified").show();
        return false;
    })

    $("#change_price").bind("ajax:complete", function(xhr, data) {
        if(data.status == 200){
            alert('更新成功');
            location.reload();
        }else{
            alert('更新失败');
        }
    })
})