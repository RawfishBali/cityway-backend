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

  if($("#commonplace_override_major").is(':checked')){
    $(".replaceable_div").slideDown();
  }else{
    $(".replaceable_div").slideUp();
  }

  $("#commonplace_override_major").change(function(){
	   if($("#commonplace_override_major").is(':checked')){
       $(".replaceable_div").slideDown();
     }else{
       $(".replaceable_div").slideUp();
     }
  })

  if($("#profile_unavailable").length > 0){
    if($("#profile_unavailable").is(':checked')){
      $(".unavailable-container").slideUp();
      $("#profile_appointment_start").val("");
      $("#profile_appointment_end").val("");
    }else{
      $(".unavailable-container").slideDown();
    }
  }

  $("#profile_unavailable").change(function(){
	   if($("#profile_unavailable").is(':checked')){
       $(".unavailable-container").slideUp();
       $("#profile_appointment_start").val("");
       $("#profile_appointment_end").val("");
     }else{
       $(".unavailable-container").slideDown();
     }
  })


  $("#merchant_is_basic").change(function(){
	   if($("#merchant_is_basic").is(':checked')){
       $(".not-basic").slideUp();
     }else{
       $(".not-basic").slideDown();
     }
  })

  $("#sport_map_toggle").change(function(){
     if($("#sport_map_toggle").is(':checked')){
       $(".not-basic").slideDown();
     }else{
       $(".not-basic").slideUp();
     }
  })

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
    if(location.href.indexOf("/admin/places/") > 0){
      if ($('#photos .nested-fields:visible').length == 3) {
       $('#photos .links a').hide();
       } else {
         $('#photos .links a').show();
       }
    }
    $('select').selectize()
    $('.dropzone').html5imageupload({
      onSave: function() {
      }
    });
  })
  .on('cocoon:after-remove', function(e, added_task) {
    if(location.href.indexOf("/admin/places/") > 0){
      if ($('#photos .nested-fields:visible').length < 3) {
       $('#photos .links a').show();
       } else {
         $('#photos .links a').hide();
       }
    }
  })
  if(location.href.indexOf("/admin/places/") > 0){
    if ($('#photos .nested-fields:visible').length == 3) {
     $('#photos .links a').hide();
     } else {
       $('#photos .links a').show();
     }
  }

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

  $('#promo_original_price').change(function(){
    $('#promo_original_price').val(parseFloat($('#promo_original_price').val()).toFixed(2))
    $('#promo_discount_price').val(parseFloat($('#promo_discount_price').val()).toFixed(2))
    $("#promo_discount_price").parent().addClass('md-input-filled');
    $("#promo_original_price").parent().addClass('md-input-filled');
    $('#promo_discount').parent().addClass('md-input-filled');

    if($('#promo_discount').val()){

      $("#promo_discount_price").val(
        parseFloat($('#promo_original_price').val() - (
          $('#promo_original_price').val() * ($('#promo_discount').val()/100)
        )).toFixed(2)
      )
      return
    }

    if($('#promo_discount_price').val()){
      $("#promo_discount").val(
        ($('#promo_discount_price').val() / $('#promo_original_price').val()) * 100
      )
      return
    }
  })

  $('#promo_discount').change(function(){
    $('#promo_original_price').val(parseFloat($('#promo_original_price').val()).toFixed(2))
    $('#promo_discount_price').val(parseFloat($('#promo_discount_price').val()).toFixed(2))
    $("#promo_discount_price").parent().addClass('md-input-filled');
    $("#promo_original_price").parent().addClass('md-input-filled');
    $('#promo_discount').parent().addClass('md-input-filled');

    if($('#promo_original_price').val()){
      $("#promo_discount_price").val(
        parseFloat($('#promo_original_price').val() - (
          $('#promo_original_price').val() * ($('#promo_discount').val()/100)
        )).toFixed(2)
      )
      return
    }

    if($('#promo_discount_price').val()){
      $("#promo_original_price").val(
        parseFloat(
          (100 / (100 - $('#promo_discount').val()) * $("#promo_discount_price").val())
        ).toFixed(2)
      )
      return
    }

  })

  $('#promo_discount_price').change(function(){
    $('#promo_original_price').val(parseFloat($('#promo_original_price').val()).toFixed(2))
    $('#promo_discount_price').val(parseFloat($('#promo_discount_price').val()).toFixed(2))
    $("#promo_discount_price").parent().addClass('md-input-filled');
    $("#promo_original_price").parent().addClass('md-input-filled');
    $('#promo_discount').parent().addClass('md-input-filled');

    if($('#promo_original_price').val()){
      $("#promo_discount").val(
        parseFloat(100 - (
          $("#promo_discount_price").val() / $("#promo_original_price").val()
        ) * 100).toFixed(1)
      )
      return
    }

    if($('#promo_discount').val()){
      $("#promo_original_price").val(
        parseFloat(
          (100 / (100 - $('#promo_discount').val()) * $("#promo_discount_price").val())
        ).toFixed(2)
      )
      return
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


  if($("#course_types").length > 0){

    var course_types = $("#course_types").val().split(',')

    var course_typesDS = new kendo.data.DataSource({
      data: course_types
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

    var autoComplete = $("#course_course_type").kendoAutoComplete({
      filter: "startswith",
      placeholder: "Seleziona o crea una nuova sottocategoria",
      separator: "  ",
      dataSource: {
        transport: {
          read: function (options, operation) {
            course_typesDS.read();
            course_typesDS.filter({logic: "and", filters: getFilters(options.data.filter.filters[0])});
            options.success(course_typesDS.view());
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


  if($("#utility_map").length > 0){
    if($("#utility_place_latitude").val() == "" && $("#utility_place_longitude").val() == ""){
      var lat = 45.5454787
      var long = 11.535421400000018
    }else{
      var lat = $("#utility_place_latitude").val()
      var long = $("#utility_place_longitude").val()
    }
    map = new GMaps({
      div: '#utility_map',
      lat: lat,
      lng: long
    });

    map.addMarker({
      lat: $("#utility_place_latitude").val(),
      lng: $("#utility_place_longitude").val(),
    });

    $('#utility_place_address').keyup(function() {
      delay(function(){
        GMaps.geocode({
          address: $('#utility_place_address').val(),
          callback: function(results, status) {
            if (status == 'OK') {
              map.removeMarkers();
              var latlng = results[0].geometry.location;
              map.setCenter(latlng.lat(), latlng.lng());
              map.addMarker({
                lat: latlng.lat(),
                lng: latlng.lng()
              });
              $("#utility_place_latitude").parent().addClass('md-input-filled')
              $("#utility_place_longitude").parent().addClass('md-input-filled')
              $("#utility_place_latitude").val(latlng.lat())
              $("#utility_place_longitude").val(latlng.lng())
            }
          }
        });
      }, 500 );
    });

    $("#utility_place_latitude, #utility_place_longitude").keyup(function() {
      delay(function(){
        if($("#utility_place_latitude").val() != "" && $("#utility_place_longitude").val() != "" && $.isNumeric($("#utility_place_latitude").val()) && $.isNumeric($("#utility_place_longitude").val()) ){
          map.removeMarkers();
          var index = map.markers.length;
          var lat = $("#utility_place_latitude").val()
          var lng = $("#utility_place_longitude").val()

          geocode_url = "http://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&sensor=true"

          $.ajax({
            url: geocode_url,
            context: document.body
          }).done(function(data) {
            if(data["status"] =="OK"){
              $("#utility_place_address").val(data["results"][0]["formatted_address"])
              $("#utility_place_address").parent().addClass('md-input-filled')
            }

          });

          map.addMarker({
            lat: lat,
            lng: lng,
            title: 'Marker #' + index
          });

          map.setCenter(lat, lng);
          $("#utility_place_latitude").parent().addClass('md-input-filled')
          $("#utility_place_longitude").parent().addClass('md-input-filled')
          $("#utility_place_latitude").val(lat);
          $("#utility_place_longitude").val(lng);

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
          $("#utility_place_address").val(data["results"][0]["formatted_address"])
          $("#utility_place_address").parent().addClass('md-input-filled')
        }
      });

      map.addMarker({
        lat: lat,
        lng: lng,
        title: 'Marker #' + index
      });

      map.setCenter(lat, lng);
      $("#utility_place_latitude").parent().addClass('md-input-filled')
      $("#utility_place_longitude").parent().addClass('md-input-filled')
      $("#utility_place_latitude").val(lat);
      $("#utility_place_longitude").val(lng);
    });
  }


  if($("#map_trigger").is(':checked')){
    $("#utility_map_container").slideDown();
  }else{
    $("#utility_map_container").slideUp();
  }


  $("#map_trigger").change(function(){
    if($("#map_trigger").is(':checked')){
      $("#utility_map_container").slideDown();
    }else{
      $("#utility_map_container").slideUp();
    }
  })


  if($("#map_trigger_course"),length > 0){
    if($("#map_trigger_course").is(':checked')){
      $(".map-container-corsi").slideDown();
    }else{
      $(".map-container-corsi").slideUp();
    }
  }

  $("#map_trigger_course").change(function(){
    if($("#map_trigger_course").is(':checked')){
      $(".map-container-corsi").slideDown();
    }else{
      $(".map-container-corsi").slideUp();
    }
  })



  if($("#parking_lot_map").length > 0){
    if($("#merchant_latitude").val() == "" && $("#parking_lot_longitude").val() == ""){
      var lat = 45.5454787
      var long = 11.535421400000018
    }else{
      var lat = $("#parking_lot_latitude").val()
      var long = $("#parking_lot_longitude").val()
    }
    map = new GMaps({
      div: '#parking_lot_map',
      lat: lat,
      lng: long
    });

    map.addMarker({
      lat: $("#parking_lot_latitude").val(),
      lng: $("#parking_lot_longitude").val(),
    });

    $('#parking_lot_address').keyup(function() {
      delay(function(){
        GMaps.geocode({
          address: $('#parking_lot_address').val(),
          callback: function(results, status) {
            if (status == 'OK') {
              map.removeMarkers();
              var latlng = results[0].geometry.location;
              map.setCenter(latlng.lat(), latlng.lng());
              map.addMarker({
                lat: latlng.lat(),
                lng: latlng.lng()
              });
              $("#parking_lot_latitude").parent().addClass('md-input-filled')
              $("#parking_lot_longitude").parent().addClass('md-input-filled')
              $("#parking_lot_latitude").val(latlng.lat())
              $("#parking_lot_longitude").val(latlng.lng())
            }
          }
        });
      }, 500 );
    });

    $("#parking_lot_latitude, #parking_lot_longitude").keyup(function() {
      delay(function(){
        if($("#parking_lot_latitude").val() != "" && $("#parking_lot_longitude").val() != "" && $.isNumeric($("#parking_lot_latitude").val()) && $.isNumeric($("#parking_lot_longitude").val()) ){
          map.removeMarkers();
          var index = map.markers.length;
          var lat = $("#parking_lot_latitude").val()
          var lng = $("#parking_lot_longitude").val()

          geocode_url = "http://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&sensor=true"

          $.ajax({
            url: geocode_url,
            context: document.body
          }).done(function(data) {
            if(data["status"] =="OK"){
              $("#parking_lot_address").val(data["results"][0]["formatted_address"])
              $("#parking_lot_address").parent().addClass('md-input-filled')
            }

          });

          map.addMarker({
            lat: lat,
            lng: lng,
            title: 'Marker #' + index
          });

          map.setCenter(lat, lng);
          $("#parking_lot_latitude").parent().addClass('md-input-filled')
          $("#mparking_lot_longitude").parent().addClass('md-input-filled')
          $("#parking_lot_latitude").val(lat);
          $("#parking_lot_longitude").val(lng);

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
          $("#parking_lot_address").val(data["results"][0]["formatted_address"])
          $("#parking_lot_address").parent().addClass('md-input-filled')
        }
      });

      map.addMarker({
        lat: lat,
        lng: lng,
        title: 'Marker #' + index
      });

      map.setCenter(lat, lng);
      $("#parking_lot_latitude").parent().addClass('md-input-filled')
      $("#parking_lot_longitude").parent().addClass('md-input-filled')
      $("#parking_lot_latitude").val(lat);
      $("#parking_lot_longitude").val(lng);
    });
  }





  if($("#sport_map").length > 0){
    if($("#sport_latitude").val() == "" && $("#sport_longitude").val() == ""){
      var lat = 45.5454787
      var long = 11.535421400000018
    }else{
      var lat = $("#sport_latitude").val()
      var long = $("#sport_longitude").val()
    }
    map = new GMaps({
      div: '#sport_map',
      lat: lat,
      lng: long
    });

    map.addMarker({
      lat: $("#sport_latitude").val(),
      lng: $("#sport_longitude").val(),
    });

    $('#sport_address').keyup(function() {
      delay(function(){
        GMaps.geocode({
          address: $('#sport_address').val(),
          callback: function(results, status) {
            if (status == 'OK') {
              map.removeMarkers();
              var latlng = results[0].geometry.location;
              map.setCenter(latlng.lat(), latlng.lng());
              map.addMarker({
                lat: latlng.lat(),
                lng: latlng.lng()
              });
              $("#sport_latitude").parent().addClass('md-input-filled')
              $("#sport_longitude").parent().addClass('md-input-filled')
              $("#sport_latitude").val(latlng.lat())
              $("#sport_longitude").val(latlng.lng())
            }
          }
        });
      }, 500 );
    });

    $("#sport_latitude, #sport_longitude").keyup(function() {
      delay(function(){
        if($("#sport_latitude").val() != "" && $("#sport_longitude").val() != "" && $.isNumeric($("#sport_latitude").val()) && $.isNumeric($("#sport_longitude").val()) ){
          map.removeMarkers();
          var index = map.markers.length;
          var lat = $("#sport_latitude").val()
          var lng = $("#sport_longitude").val()

          geocode_url = "http://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&sensor=true"

          $.ajax({
            url: geocode_url,
            context: document.body
          }).done(function(data) {
            if(data["status"] =="OK"){
              $("#sport_address").val(data["results"][0]["formatted_address"])
              $("#sport_address").parent().addClass('md-input-filled')
            }

          });

          map.addMarker({
            lat: lat,
            lng: lng,
            title: 'Marker #' + index
          });

          map.setCenter(lat, lng);
          $("#sport_latitude").parent().addClass('md-input-filled')
          $("#sport_longitude").parent().addClass('md-input-filled')
          $("#sport_latitude").val(lat);
          $("#sport_longitude").val(lng);

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
          $("#sport_address").val(data["results"][0]["formatted_address"])
          $("#sport_address").parent().addClass('md-input-filled')
        }
      });

      map.addMarker({
        lat: lat,
        lng: lng,
        title: 'Marker #' + index
      });

      map.setCenter(lat, lng);
      $("#sport_latitude").parent().addClass('md-input-filled')
      $("#sport_longitude").parent().addClass('md-input-filled')
      $("#sport_latitude").val(lat);
      $("#sport_longitude").val(lng);
    });
  }



  if($("#school_map").length > 0){
    if($("#school_latitude").val() == "" && $("#school_longitude").val() == ""){
      var lat = 45.5454787
      var long = 11.535421400000018
    }else{
      var lat = $("#school_latitude").val()
      var long = $("#school_longitude").val()
    }
    map = new GMaps({
      div: '#school_map',
      lat: lat,
      lng: long
    });

    map.addMarker({
      lat: $("#school_latitude").val(),
      lng: $("#school_longitude").val(),
    });

    $('#school_address').keyup(function() {
      delay(function(){
        GMaps.geocode({
          address: $('#school_address').val(),
          callback: function(results, status) {
            if (status == 'OK') {
              map.removeMarkers();
              var latlng = results[0].geometry.location;
              map.setCenter(latlng.lat(), latlng.lng());
              map.addMarker({
                lat: latlng.lat(),
                lng: latlng.lng()
              });
              $("#school_latitude").parent().addClass('md-input-filled')
              $("#school_longitude").parent().addClass('md-input-filled')
              $("#school_latitude").val(latlng.lat())
              $("#school_longitude").val(latlng.lng())
            }
          }
        });
      }, 500 );
    });

    $("#school_latitude, #school_longitude").keyup(function() {
      delay(function(){
        if($("#school_latitude").val() != "" && $("#school_longitude").val() != "" && $.isNumeric($("#school_latitude").val()) && $.isNumeric($("#school_longitude").val()) ){
          map.removeMarkers();
          var index = map.markers.length;
          var lat = $("#school_latitude").val()
          var lng = $("#school_longitude").val()

          geocode_url = "http://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&sensor=true"

          $.ajax({
            url: geocode_url,
            context: document.body
          }).done(function(data) {
            if(data["status"] =="OK"){
              $("#school_address").val(data["results"][0]["formatted_address"])
              $("#school_address").parent().addClass('md-input-filled')
            }

          });

          map.addMarker({
            lat: lat,
            lng: lng,
            title: 'Marker #' + index
          });

          map.setCenter(lat, lng);
          $("#school_latitude").parent().addClass('md-input-filled')
          $("#school_longitude").parent().addClass('md-input-filled')
          $("#school_latitude").val(lat);
          $("#school_longitude").val(lng);

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
          $("#school_address").val(data["results"][0]["formatted_address"])
          $("#school_address").parent().addClass('md-input-filled')
        }
      });

      map.addMarker({
        lat: lat,
        lng: lng,
        title: 'Marker #' + index
      });

      map.setCenter(lat, lng);
      $("#school_latitude").parent().addClass('md-input-filled')
      $("#school_longitude").parent().addClass('md-input-filled')
      $("#school_latitude").val(lat);
      $("#school_longitude").val(lng);
    });
  }


  if($("#parking_lot_map").length > 0){
    if($("#parking_lot_latitude").val() == "" && $("#parking_lot_longitude").val() == ""){
      var lat = 45.5454787
      var long = 11.535421400000018
    }else{
      var lat = $("#parking_lot_latitude").val()
      var long = $("#parking_lot_longitude").val()
    }
    map = new GMaps({
      div: '#parking_lot_map',
      lat: lat,
      lng: long
    });

    map.addMarker({
      lat: $("#parking_lot_latitude").val(),
      lng: $("#parking_lot_longitude").val(),
    });

    $('#parking_lot_address').keyup(function() {
      delay(function(){
        GMaps.geocode({
          address: $('#parking_lot_address').val(),
          callback: function(results, status) {
            if (status == 'OK') {
              map.removeMarkers();
              var latlng = results[0].geometry.location;
              map.setCenter(latlng.lat(), latlng.lng());
              map.addMarker({
                lat: latlng.lat(),
                lng: latlng.lng()
              });
              $("#parking_lot_latitude").parent().addClass('md-input-filled')
              $("#parking_lot_longitude").parent().addClass('md-input-filled')
              $("#parking_lot_latitude").val(latlng.lat())
              $("#parking_lot_longitude").val(latlng.lng())
            }
          }
        });
      }, 500 );
    });

    $("#parking_lot_latitude, #parking_lot_longitude").keyup(function() {
      delay(function(){
        if($("#parking_lot_latitude").val() != "" && $("#parking_lot_longitude").val() != "" && $.isNumeric($("#parking_lot_latitude").val()) && $.isNumeric($("#parking_lot_longitude").val()) ){
          map.removeMarkers();
          var index = map.markers.length;
          var lat = $("#parking_lot_latitude").val()
          var lng = $("#parking_lot_longitude").val()

          geocode_url = "http://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&sensor=true"

          $.ajax({
            url: geocode_url,
            context: document.body
          }).done(function(data) {
            if(data["status"] =="OK"){
              $("#parking_lot_address").val(data["results"][0]["formatted_address"])
              $("#parking_lot_address").parent().addClass('md-input-filled')
            }

          });

          map.addMarker({
            lat: lat,
            lng: lng,
            title: 'Marker #' + index
          });

          map.setCenter(lat, lng);
          $("#parking_lot_latitude").parent().addClass('md-input-filled')
          $("#parking_lot_longitude").parent().addClass('md-input-filled')
          $("#parking_lot_latitude").val(lat);
          $("#parking_lot_longitude").val(lng);

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
          $("#parking_lot_address").val(data["results"][0]["formatted_address"])
          $("#parking_lot_address").parent().addClass('md-input-filled')
        }
      });

      map.addMarker({
        lat: lat,
        lng: lng,
        title: 'Marker #' + index
      });

      map.setCenter(lat, lng);
      $("#parking_lot_latitude").parent().addClass('md-input-filled')
      $("#parking_lot_longitude").parent().addClass('md-input-filled')
      $("#parking_lot_latitude").val(lat);
      $("#parking_lot_longitude").val(lng);
    });
  }


  if($("#course_map").length > 0){
    if($("#course_latitude").val() == "" && $("#course_longitude").val() == ""){
      var lat = 45.5454787
      var long = 11.535421400000018
    }else{
      var lat = $("#course_latitude").val()
      var long = $("#course_longitude").val()
    }
    map = new GMaps({
      div: '#course_map',
      lat: lat,
      lng: long
    });

    map.addMarker({
      lat: $("#course_latitude").val(),
      lng: $("#course_longitude").val(),
    });

    $('#course_address').keyup(function() {
      delay(function(){
        GMaps.geocode({
          address: $('#course_address').val(),
          callback: function(results, status) {
            if (status == 'OK') {
              map.removeMarkers();
              var latlng = results[0].geometry.location;
              map.setCenter(latlng.lat(), latlng.lng());
              map.addMarker({
                lat: latlng.lat(),
                lng: latlng.lng()
              });
              $("#course_latitude").parent().addClass('md-input-filled')
              $("#course_longitude").parent().addClass('md-input-filled')
              $("#course_latitude").val(latlng.lat())
              $("#course_longitude").val(latlng.lng())
            }
          }
        });
      }, 500 );
    });

    $("#course_latitude, #course_longitude").keyup(function() {
      delay(function(){
        if($("#course_latitude").val() != "" && $("#course_longitude").val() != "" && $.isNumeric($("#course_latitude").val()) && $.isNumeric($("#course_longitude").val()) ){
          map.removeMarkers();
          var index = map.markers.length;
          var lat = $("#course_latitude").val()
          var lng = $("#course_longitude").val()

          geocode_url = "http://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&sensor=true"

          $.ajax({
            url: geocode_url,
            context: document.body
          }).done(function(data) {
            if(data["status"] =="OK"){
              $("#course_address").val(data["results"][0]["formatted_address"])
              $("#course_address").parent().addClass('md-input-filled')
            }

          });

          map.addMarker({
            lat: lat,
            lng: lng,
            title: 'Marker #' + index
          });

          map.setCenter(lat, lng);
          $("#course_latitude").parent().addClass('md-input-filled')
          $("#course_longitude").parent().addClass('md-input-filled')
          $("#course_latitude").val(lat);
          $("#course_longitude").val(lng);

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
          $("#course_address").val(data["results"][0]["formatted_address"])
          $("#course_address").parent().addClass('md-input-filled')
        }
      });

      map.addMarker({
        lat: lat,
        lng: lng,
        title: 'Marker #' + index
      });

      map.setCenter(lat, lng);
      $("#course_latitude").parent().addClass('md-input-filled')
      $("#course_longitude").parent().addClass('md-input-filled')
      $("#course_latitude").val(lat);
      $("#course_longitude").val(lng);
    });
  }

})
