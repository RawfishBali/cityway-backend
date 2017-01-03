$(document).ready(function(){
  var delay = (function(){
    var timer = 0;
    return function(callback, ms){
      clearTimeout (timer);
      timer = setTimeout(callback, ms);
    };
  })();

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
  if($('#advertisement_sections').length > 0){
    $('#advertisement_sections').kendoMultiSelect();
  }
  if($('#profile_days_open').length > 0){
    $('#profile_days_open').kendoMultiSelect();
  }
  if($('#merchant_city_ids').length > 0){
    $('#merchant_city_ids').kendoMultiSelect();
  }
  if($('#event_city_ids').length > 0){
    $('#event_city_ids').kendoMultiSelect();
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
    persist: false,
    maxItems: 1,
    valueField: 'id',
    labelField: 'name',
    searchField: ['name', 'id'],
    onDropdownOpen: function($dropdown) {
      $dropdown
      .hide()
      .velocity('slideDown', {
        begin: function() {
          $dropdown.css({'margin-top':'0'})
        },
        duration: 200,
        easing: easing_swiftOut
      })
    }
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
      placeholder: "Seleziona o crea una nuova sottocategoria",
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
      placeholder: "Seleziona o crea una nuova sottocategoria",
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

  $("#ztl_color").kendoColorPicker({
    buttons: false
  });

  if($("#map").length > 0){
    if($("#merchant_latitude").val() == "" && $("#merchant_longitude").val() == ""){
      var lat = 45.5454787
      var long = 11.535421400000018
    }else{
      var lat = $("#merchant_latitude").val()
      var long = $("#merchant_longitude").val()
    }
    map = new GMaps({
      div: '#map',
      lat: lat,
      lng: long
    });

    map.addMarker({
      lat: $("#merchant_latitude").val(),
      lng: $("#merchant_longitude").val(),
    });

    $('#merchant_address').keyup(function() {
      delay(function(){
        GMaps.geocode({
          address: $('#merchant_address').val(),
          callback: function(results, status) {
            if (status == 'OK') {
              map.removeMarkers();
              var latlng = results[0].geometry.location;
              map.setCenter(latlng.lat(), latlng.lng());
              map.addMarker({
                lat: latlng.lat(),
                lng: latlng.lng()
              });
              $("#merchant_latitude").parent().addClass('md-input-filled')
              $("#merchant_longitude").parent().addClass('md-input-filled')
              $("#merchant_latitude").val(latlng.lat())
              $("#merchant_longitude").val(latlng.lng())
            }
          }
        });
      }, 500 );
    });

    $("#merchant_latitude, #merchant_longitude").keyup(function() {
      delay(function(){
        if($("#merchant_latitude").val() != "" && $("#merchant_longitude").val() != "" && $.isNumeric($("#merchant_latitude").val()) && $.isNumeric($("#merchant_longitude").val()) ){
          map.removeMarkers();
          var index = map.markers.length;
          var lat = $("#merchant_latitude").val()
          var lng = $("#merchant_longitude").val()

          geocode_url = "http://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&sensor=true"

          $.ajax({
            url: geocode_url,
            context: document.body
          }).done(function(data) {
            if(data["status"] =="OK"){
              $("#merchant_address").val(data["results"][0]["formatted_address"])
              $("#merchant_address").parent().addClass('md-input-filled')
            }

          });

          map.addMarker({
            lat: lat,
            lng: lng,
            title: 'Marker #' + index
          });

          map.setCenter(lat, lng);
          $("#merchant_latitude").parent().addClass('md-input-filled')
          $("#merchant_longitude").parent().addClass('md-input-filled')
          $("#merchant_latitude").val(lat);
          $("#merchant_longitude").val(lng);

        }


      }, 500 );
    });

    GMaps.on('click', map.map, function(event) {
      map.removeMarkers();
      var index = map.markers.length;
      var lat = event.latLng.lat();
      var lng = event.latLng.lng();

      geocode_url = "https://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&sensor=true"

      $.ajax({
        url: geocode_url,
        context: document.body
      }).done(function(data) {
        if(data["status"] =="OK"){
          $("#merchant_address").val(data["results"][0]["formatted_address"])
          $("#merchant_address").parent().addClass('md-input-filled')
        }
      });

      map.addMarker({
        lat: lat,
        lng: lng,
        title: 'Marker #' + index
      });

      map.setCenter(lat, lng);
      $("#merchant_latitude").parent().addClass('md-input-filled')
      $("#merchant_longitude").parent().addClass('md-input-filled')
      $("#merchant_latitude").val(lat);
      $("#merchant_longitude").val(lng);
    });
  }




})
