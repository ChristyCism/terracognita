// image gallery
// init the state from the input
$(".tile").each(function () {
  if ($(this).find('input[type="radio"]').first().attr("checked")) {
    $(this).addClass('shadow-pop-bl');
  }
  else {
    $(this).removeClass('shadow-pop-bl');
  }
});

// sync the state to the input
$(".tile").on("click", function (e) {
  $(this).toggleClass('shadow-pop-bl');
  var $radio = $(this).find('input[type="radio"]');
  $radio.prop("checked",!$radio.prop("checked"))

  e.preventDefault();
});


