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
//= require bootstrap-editable
//= require jquery_ujs
// require jquery


var skybulls = {

     handleAjaxError : function(data){

         $(".flash-message-area").append('<div class="alert alert-error"><a class="close" data-dismiss="alert">×</a><strong>Error! </strong>'+data["message"]+'</div>');

     }


};

$.fn.editable.defaults.mode = 'inline';

jQuery(document).ready(function(){
    $('#dateFields').datepicker( {dateFormat: "yy-mm-dd",
                                    minDate: Date.now()
                                    } );


    $('section.left-area').affix();



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


