// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-datepicker
//= require foundation
//= require 'jquery.backstretch'
//= require_tree .

$(function(){ $(document).foundation(); });

$(function() {
  $('.datepicker').datepicker({
    format: "dd MM yyyy",
    weekStart: 1,
    todayBtn: "linked",
    autoclose: true,
    todayHighlight: true
  });
});

$( document ).ready( function(){
  $.backstretch("/assets/cover.jpg");

  $("td" ).click( function() {
    var date = $( this ).attr( "data-date" );
    $('input.date').val(date);
  });

  $("input.transaction-type").on("click", function(){
    if($(this).attr('id') == 'transaksi_add_saving'){
      $( "#select_saving" ).show('fast');
    }
    if($(this).attr('id') == 'transaksi_add_outcome' || $(this).attr('id') == 'transaksi_add_income'){
      $( "#select_saving" ).hide('fast');
    }
  });

  $(window).bind("load", function () {
      var footer = $("#footer");
      var pos = footer.position();
      var height = $(window).height();
      height = height - pos.top;
      height = height - footer.height();
      if (height > 0) {
          footer.css({
              'margin-top': height + 'px'
          });
      }
  });
  
});
