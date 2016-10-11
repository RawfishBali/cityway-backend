$(document).ready(function(){
  if($('#merchant_subcategory_ids').length > 0){
    $('#merchant_subcategory_ids').kendoMultiSelect();
  }
  $('.dropzone').html5imageupload();

  $('#subcategories')
  .on('cocoon:after-insert', function(e, added_task) {
    $('select').selectize()
    $('.dropzone').html5imageupload();
  })

  $('#photos')
  .on('cocoon:after-insert', function(e, added_task) {
    $('.dropzone').html5imageupload();
  })

})
