$(document).ready(function(){
  if($('#merchant_subcategories').length > 0){
    $('#merchant_subcategories').kendoMultiSelect();
  }

  $('#subcategories')
    .on('cocoon:after-insert', function(e, added_task) {
      $('select').selectize()
    })
})
