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
//= require jquery_ujs
// require jquery

jQuery(document).ready(function(){
    $('#dateFields').datepicker( {dateFormat: "yy-mm-dd",
                                    minDate: Date.now()
                                    } );

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
        type      : 'textarea',
        cancel    : 'Cancel',
        submit    : 'OK',
        tooltip   : 'Click to edit...'
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

    $('.popup_box').click(function(){
        var element = $('#'+this.id);
        var data_map= {}
        data_map['id']=element.attr('data-id');
        $.ajax({
            type : 'GET',
            url : element.attr('data-ajaxInfoUrl'),
            data: data_map,
            dataType: 'html',
            success:function(data) {
                $('.popup-area').html('');
                $('.popup-area').append(data);
                $('.popup-area').dialog({   modal: true,
                    autoOpen:true,
                    minWidth:400

                });
            }
        });
    });
});

function registerLeague(leagueId){
        var data_map = {};
        data_map['id']=leagueId;
        var register_url = $('#registerUrl').val()
        $.ajax({
            type : 'GET',
            url : register_url,
            data: data_map,
            dataType: 'html',
            success:function(data){
                $('.popup-area').dialog('close');
                $('.popup-area').html('');
                $('.popup-area').append(data);
                $('.popup-area').dialog('open');
            }
            });
    }
