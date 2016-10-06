$(document).ready(function(){
  if($('#merchant_subcategories').length > 0){
    $('#merchant_subcategories').kendoMultiSelect();
  }

  $('#subcategories')
  .on('cocoon:after-insert', function(e, added_task) {
    $('select').selectize()
    $('.datepicker').each(function( index ) {
      UIkit.datepicker($( this ), {
        format:'YYYY-MM-DD'
      });
    });
  })

  UIkit.datepicker($('.datepicker'), {
    format:'YYYY-MM-DD'
  });
})
