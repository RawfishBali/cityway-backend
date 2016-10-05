
$(window).ready(function(){
  $('#cities').change(function() {
    // set the window's location property to the value of the option the user has selected
    window.location.href = "/admin/cities/" + $(this).val() + "/edit"
  });
})
