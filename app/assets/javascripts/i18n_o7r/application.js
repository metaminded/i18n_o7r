// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require ./jquery.autosize.min
//= require ./easyTree
//= require ./i18n_o7r

jQuery(function($){
  $('.autosize').autosize();

  $("a.edit-key[data-remote]").on("ajax:success", function(e, data, status, xhr){
    $(data).modal();
  });

  $('a.mark-key, a.unmark-key').on("ajax:success", function(e, data, status, xhr){
    window.location.reload();
  }).on('ajax:error', function(x, xhr, status, error){
    $('.modification-buttons').removeClass('hide');
    $(this).parents($('.modification-buttons')).siblings('.spinner').hide();
  });

  $('a.mark-key, a.unmark-key').on('click', function(){
    $('.modification-buttons').addClass('hide');
    $(this).parents($('.modification-buttons')).siblings('.spinner').show();
  });

  $(document).on('submit', '#update_key_form', function(e){
    $('.update_key_buttons').hide();
    $('.spinner').show();
  });

  $(document).on("ajax:success", "#update_key_form", function(e, data, status, xhr){
    window.location.reload();
  }).on("ajax:error", "#update_key_form", function(e, xhr, status, error){
    $('.update_key_buttons').show();
    $('.spinner').hide();
  });

  $(document).on('click', '.key', function(){$(this).siblings('.prefix').show()})
});
