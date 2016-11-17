$(document).ready(function(){
  $.LoadingOverlaySetup({
    color           : "rgba(255, 255, 255, 0.7)",
    resizeInterval  : 0,
    size            : "50%",
    zIndex          : 9999,
    image       : "",
    fontawesome : "fa fa fa-spinner fa-pulse"
  });
  if($('#merchant_subcategory_ids').length > 0){
    $('#merchant_subcategory_ids').kendoMultiSelect();
  }
  if($('#advertisement_city_ids').length > 0){
    $('#advertisement_city_ids').kendoMultiSelect();
  }
  if($('#profile_days_open').length > 0){
    $('#profile_days_open').kendoMultiSelect();
  }

  var url = window.location.pathname.split("/");
  if(url[2] == "city_hall_stories"){
    $(".add_fields").click();
  }

  $('.dropzone').html5imageupload({
    onSave: function() {
    },
    onAfterInitImage: function() {
    }
  });

  $('.kendo-timer-input-profile').kendoTimePicker({
    format: "HH:mm"
  });

  $("#subcategories .kendo-timer-input").kendoTimePicker({
    format: "HH:mm"
  });

  $('#subcategories')
  .on('cocoon:after-insert', function(e, added_task) {
    $('#subcategories select').selectize()
    $(".nested-business-hours:last .kendo-timer-input").kendoTimePicker({
      format: "HH:mm"
    });
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

  $("form").submit(function( event ) {
    $.LoadingOverlay("show");
    $(".waves-button").attr('disabled','disabled')
    // event.preventDefault();
  });

  $(".delete-town").click(function( event ) {
    $.LoadingOverlay("show");
    $(".waves-button").attr('disabled','disabled')
    // event.preventDefault();
  });


  $('#promo_original_price , #promo_discount').change(function(){
    $('#promo_original_price').val(parseFloat($('#promo_original_price').val()).toFixed(2))
    $("#promo_discount_price").parent().addClass('md-input-filled');
    $("#promo_discount_price").val(
      parseFloat($('#promo_original_price').val() - (
        $('#promo_original_price').val() * ($('#promo_discount').val()/100)
      )).toFixed(2)
    )
  })



})
