$(function(){
    $('.crowdfunding-mutil-infos li').sortable();

    $('.cf-category-li span').bind('click', function(){
        var target = '#cf-textarea-' + $(this).data('id');
        $('.has_many_container fieldset').hide();
        $(target).parents('fieldset.has_many_fields').show();
    })
});