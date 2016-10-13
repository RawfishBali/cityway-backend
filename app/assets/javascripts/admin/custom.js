$(document).ready(function(){
  if($('#merchant_subcategory_ids').length > 0){
    $('#merchant_subcategory_ids').kendoMultiSelect();


  }
  if($('#advertisement_city_ids').length > 0){
    $('#advertisement_city_ids').kendoMultiSelect();
  }

  // $('.dropzone').html5imageupload();


  $('.dropzone').html5imageupload({
    onSave: function() {
    },
    onAfterInitImage: function() {
    }
  });

  $('#subcategories')
  .on('cocoon:after-insert', function(e, added_task) {
    $('select').selectize()
    $('.dropzone').html5imageupload({
      onSave: function() {
      }
    });
  })

  $('#photos')
  .on('cocoon:after-insert', function(e, added_task) {
    $('select').selectize()
    $('.dropzone').html5imageupload({
      onSave: function() {
      }
    });
  })

})
