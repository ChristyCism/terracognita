import interact from 'interactjs'

interact('.drag-rotate')
  .draggable({
  onstart: function (event) {
    const element = event.target;
    const rect = element.getBoundingClientRect();

    // store the center as the element has css `transform-origin: center center`
    element.dataset.centerX = rect.left + rect.width / 2;
    element.dataset.centerY = rect.top + rect.height / 2;
    // get the angle of the element when the drag starts
    element.dataset.angle = getDragAngle(event);
  },
  onmove: function (event) {
    var element = event.target;
    var center = {
      x: parseFloat(element.dataset.centerX) || 0,
      y: parseFloat(element.dataset.centerY) || 0,
    };
    var angle = getDragAngle(event);

    // update transform style on dragmove
    element.style.transform = 'rotate(' + angle + 'rad' + ')';
  },
  onend: function (event) {
    const element = event.target;

    // save the angle on dragend
    element.dataset.angle = getDragAngle(event);
  },
})

function getDragAngle(event) {
  var element = event.target;
  var startAngle = parseFloat(element.dataset.angle) || 0;
  var center = {
    x: parseFloat(element.dataset.centerX) || 0,
    y: parseFloat(element.dataset.centerY) || 0,
  };
  var angle = Math.atan2(center.y - event.clientY,
                         center.x - event.clientX);

  document.getElementById("angle").value = angle;

  let anglePlusPi = angle + Math.PI;

  if (anglePlusPi >= (0.75 * Math.PI) && anglePlusPi < (1.25 * Math.PI)) {
    document.getElementById("angle").value = "D";
  } else if (anglePlusPi >= (1.25 * Math.PI) && anglePlusPi < (1.75 * Math.PI)) {
    document.getElementById("angle").value = "A";
  } else if (anglePlusPi >= (0.25 * Math.PI) && anglePlusPi < (0.75 * Math.PI)) {
    document.getElementById("angle").value = "C";
  } else {
    document.getElementById("angle").value = "B";
  }
  ;

  return angle - startAngle;
}
