// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//= require js-routes
//= require bootstrap
//= require bootstrap-slider
//= require jquery_ujs
// require jquery


var skybulls = {




};

jQuery(document).ready(function(){
    $('#dateFields').datepicker( {dateFormat: "yy-mm-dd",
                                    minDate: Date.now()
                                    } );

    $('section.left-area').affix();

    $('.user_info span').editable(function(value, settings) {
        var data_map= {};
        data_map['id']=this.id;
        data_map['value']=value;
        $.ajax({
            type : 'POST',
            url :$('#ajax_update_url').val() ,
            data: data_map,
            dataType: 'json'
        });

        }, {
        indicator : "Please Wait",
        tooltip   : 'Click to edit...',
        style : "inherit"
    });

    $(".checkbox-select-links a.select-all").click(function(){
        $("input[type=checkbox]", $(this).closest("li")).each(function(){
            $(this).prop("checked", true);
        });
    });

    $(".checkbox-select-links a.select-none").click(function(){
        $("input[type=checkbox]", $(this).closest("li")).each(function(){
            $(this).prop("checked", false);
        });
    });

    $("[data-role=submit]").click(function(){
        $(this).closest("form").submit();
    });

    var tradeModalElement = $("#tradeModal");
    tradeModalElement.on('click', 'a.market-price' ,function(event){
        $(".selectTradeType", tradeModalElement).hide();
        $(".confirmTrade", tradeModalElement).show();
        $(".priceRow", tradeModalElement).hide();
        $("#trade_type", tradeModalElement).val("latest");
    });

    tradeModalElement.on('click', 'a.custom-price' ,function(event){
        $(".selectTradeType", tradeModalElement).hide();
        $(".confirmTrade", tradeModalElement).show();
        $(".priceRow", tradeModalElement).show();
        $("#trade_type", tradeModalElement).val("custom");
    });

    tradeModalElement.on('change', '.stockPrice' ,function(event){
        var stockPrice =  parseFloat($(this).val());
        var stockAmount =  parseInt($("input[type=text].stockAmount", tradeModalElement).val());
        var totalPrice=  $(".totalPrice", tradeModalElement).val(Math.floor(stockPrice * stockAmount * 100) / 100);
        $('.slider-price').slider("setValue", stockPrice);
    });

    tradeModalElement.on('change', '.stockAmount' ,function(event){
        var stockAmount =  parseInt($(this).val());
        var stockPrice =  parseFloat($("input[type=text].stockPrice", tradeModalElement).val());
        var totalPrice=  $(".totalPrice", tradeModalElement).val(Math.floor(stockPrice * stockAmount * 100) / 100);
        $('.slider-amount').slider("setValue", stockAmount);
    });

    tradeModalElement.on('click', 'a.submitButton' ,function(event){
        var form =  $(this).closest("form");
        var data_map= form.serialize();
        $.ajax({
            type : 'POST',
            url : form.attr('action') ,
            data: data_map,
            success: function(data){
                tradeModalElement.html(data);
            }
        });

    });



});


