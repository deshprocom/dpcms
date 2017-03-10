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

    $(".update_order_address").bind('click', function(){
        $(".ticket_order_edit").show();
        $(".update_order_address").hide();
        $(".entity_ticket_order").hide();
        $(".e_ticket_order").hide();
    })
})