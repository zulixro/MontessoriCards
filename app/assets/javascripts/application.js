// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require foundation

$(document).on('turbolinks:load', function() {
    $(function(){ $(document).foundation(); });

    var textInput = $('#card-name')[0];
    var timeout = null;

    textInput.onkeyup = function(e) {
        clearTimeout(timeout);

        timeout = setTimeout(function () {
            $.ajax({
                type: "GET",
                url: "/cards/card_urls",
                data: { card_name: textInput.value },
                success: function(data){
                    var url = data.urls[0]
                    $('#card-url').val(url);
                    $('.card-image-tag').attr("src", url);
                },
                error: function(){
                    console.log("ups");
                }
            })
        }, 1000);
    };

    var btnPrevious = $('#btn-previous');
    var btnNext = $('#btn-next');

    btnPrevious.on("click", function() {
        console.log("test");
    });

    btnNext.on("click", function() {
        console.log("test2");
    });
});
