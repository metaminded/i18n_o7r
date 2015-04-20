$(function(){
  $('.remove-key').click(function(e){
    if(!confirm($(this).data('confirm'))){
      e.preventDefault();
      return false;
    }
  })
});
