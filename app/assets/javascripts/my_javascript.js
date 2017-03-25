$(function(){
    $(".order_price_modified").bind('click', function(){
        $(".change_price").show();
        $(".order_price").hide();
        $(".order_price_modified").hide();
    })

    $(".order_button_cancel").bind('click', function(){
        $(".change_price").hide();
        $(".order_price").show();
        $(".order_price_modified").show();
        return false;
    })

    $(".update_order_address").bind('click', function(){
        $(".ticket_order_edit").show();
        $(".update_order_address").hide();
        $(".ticket_order").hide();
    })

    $(".order_ticket_button_cancel").bind('click', function(){
        $(".ticket_order_edit").hide();
        $(".update_order_address").show();
        $(".ticket_order").show();
        return false;
    })
})