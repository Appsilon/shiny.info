hide_script <- function() {
  tags$script("
  $(document).ready(
    function() {
      $('div.info_box').hide();
    }
  );

  $(document).on('keydown', function(e) {
    if(e.which == 69) {
      $('div.info_box').toggle();
    }
  });")
}
