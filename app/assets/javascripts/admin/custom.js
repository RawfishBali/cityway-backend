$(document).ready(function(){
  if($('#merchant_subcategory_ids').length > 0){
    $('#merchant_subcategory_ids').kendoMultiSelect();
  }
  // $('.dropzone').html5imageupload();


  $('.dropzone').html5imageupload({
    onSave: function() {
      console.log('aaaaa');
    },
    onAfterInitImage: function() {
		console.log('motherfucker');
	}
  });

  $('#subcategories')
  .on('cocoon:after-insert', function(e, added_task) {
    $('select').selectize()
    $('.dropzone').html5imageupload({
      onSave: function() {
        console.log('aaaaa');
      }
    });
  })

  $('#photos')
  .on('cocoon:after-insert', function(e, added_task) {
    $('.dropzone').html5imageupload({
      onSave: function() {
        console.log('aaaaa');
      }
    });
  })

})
