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
    var index = 0
    var cardUrls = [];

    function setUrls() {
        var url = cardUrls.slice(index)[0];
        $('#card-url').val(url);
        $('.card-image-tag').attr("src", url);
    }

    function getUrls() {
        $.ajax({
            type: "GET",
            url: "/cards/card_urls",
            data: { card_name: textInput.value },
            success: function(data){
                cardUrls = data.urls;
                setUrls();
            },
            error: function(){
                console.log("ups");
            }
        })
    }

    textInput.onkeyup = function(e) {
        clearTimeout(timeout);
        timeout = setTimeout(getUrls(), 1000);
    };

    var btnPrevious = $('#btn-previous');
    btnPrevious.on("click", function() {
        index = index - 1;
        if (cardUrls.length === 0) {
            getUrls();
        } else {
            setUrls();
        }
    });

    var btnNext = $('#btn-next');
    btnNext.on("click", function() {
        index = index + 1;
        if (cardUrls.length === 0) {
            getUrls();
        } else {
            setUrls();
        }
    });
});
