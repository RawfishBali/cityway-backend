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
    $('#subcategories .dropzone').html5imageupload({
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


  $('#promo_original_price , #promo_discount, #promo_discount_price').change(function(){
    $('#promo_original_price').val(parseFloat($('#promo_original_price').val()).toFixed(2))
    $('#promo_discount_price').val(parseFloat($('#promo_discount_price').val()).toFixed(2))
    $("#promo_discount_price").parent().addClass('md-input-filled');
    $("#promo_original_price").parent().addClass('md-input-filled');

    if( $('#promo_original_price').val()  && $('#promo_discount').val()  ){
      $("#promo_discount_price").val(
        parseFloat($('#promo_original_price').val() - (
          $('#promo_original_price').val() * ($('#promo_discount').val()/100)
        )).toFixed(2)
      )
    }else if( $('#promo_discount_price').val()  && $('#promo_discount').val()  ){
      $("#promo_original_price").val(
        parseFloat((
          $('#promo_discount_price').val() * (100/$('#promo_discount').val())
        )).toFixed(2)
      )
    }


  })

  $('#promo_merchant_id').selectize({
    plugins: {
      'remove_button': {
        label     : ''
      }
    },
    persist: false,
    maxItems: null,
    valueField: 'email',
    labelField: 'name',
    searchField: ['name', 'email']
  })


  if($("#school_types").length > 0){
    var school_types = $("#school_types").val().split(',')

    var school_typesDS = new kendo.data.DataSource({
      data: school_types
    });

    var getFilters = function (filter) {
      var filters = [];
      filters.push(filter);
      values = autoComplete.value().split(", ");
      values.pop();
      $.each(values, function (index, item) {
        filters.push({field: "", ignoreCase: true, operator: "neq", value: item});
      });
      return filters;
    };

    var autoComplete = $("#school_school_type").kendoAutoComplete({
      filter: "startswith",
      placeholder: "Tipo di scuola",
      separator: "  ",
      dataSource: {
        transport: {
          read: function (options, operation) {
            school_typesDS.read();
            school_typesDS.filter({logic: "and", filters: getFilters(options.data.filter.filters[0])});
            options.success(school_typesDS.view());
          }
        },
        serverFiltering: true
      }
    }).data("kendoAutoComplete");
  }


  if($("#sport_sport_type").length > 0){
    var sport_types = $("#sport_types").val().split(',')

    var sport_typesDS = new kendo.data.DataSource({
      data: sport_types
    });

    var getFilters = function (filter) {
      var filters = [];
      filters.push(filter);
      values = autoComplete.value().split(", ");
      values.pop();
      $.each(values, function (index, item) {
        filters.push({field: "", ignoreCase: true, operator: "neq", value: item});
      });
      return filters;
    };

    var autoComplete = $("#sport_sport_type").kendoAutoComplete({
      filter: "startswith",
      placeholder: "Sport e tempo libero",
      separator: "  ",
      dataSource: {
        transport: {
          read: function (options, operation) {
            sport_typesDS.read();
            sport_typesDS.filter({logic: "and", filters: getFilters(options.data.filter.filters[0])});
            options.success(sport_typesDS.view());
          }
        },
        serverFiltering: true
      }
    }).data("kendoAutoComplete");
  }










  // $(".addressable").geocomplete();

})
