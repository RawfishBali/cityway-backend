$(document).ready(function(){
  if($('#merchant_subcategory_ids').length > 0){
    $('#merchant_subcategory_ids').kendoMultiSelect();


  }
  if($('#advertisement_city_ids').length > 0){
    $('#advertisement_city_ids').kendoMultiSelect();
  }
  if($('#profile_days_open').length > 0){
    $('#profile_days_open').kendoMultiSelect();
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

  $('#waste_pickup_schedules')
  .on('cocoon:after-insert', function(e, added_task) {
    var mdCheckbox = (typeof checkbox === 'undefined') ? $("[data-md-icheck],.data-md-icheck") : $(checkbox);
    mdCheckbox.each(function() {
      if( !$(this).next('.iCheck-helper').length ) {
        $(this)
        .iCheck({
          checkboxClass: 'icheckbox_md',
          radioClass: 'iradio_md',
          increaseArea: '20%'
        })
        // validate inputs on change (parsley)
        .on('ifChanged', function(event){
          if ( !!$(this).data('parsley-multiple') ) {
            $(this).parsley().validate();
          }
        });
      }
    });
  })

})
