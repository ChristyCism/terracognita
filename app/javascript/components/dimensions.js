import interact from 'interactjs'

const castPixelsToMeters = (pixelString) => {
  const lrg     = pixelString.match(/\d+/)[0];
  const meters  = Math.round(Number(lrg) / 30);

  return meters;
};


interact('.item-draggable')

  .resizable({
    // resize from all edges and corners
    edges: { left: false, right: true, bottom: false, top: true },
    corners: { top: true, right: true},

    // keep the edges inside the parent
    restrictEdges: {
      outer: 'parent',
      endOnly: true,
    },

    // minimum size
    restrictSize: {
      min: { width: 60, height: 60 },
    },

    inertia: true,
  })

  .on('resizemove', function (event) {
    var target = event.target,
        x = (parseFloat(target.getAttribute('data-x')) || 0),
        y = (parseFloat(target.getAttribute('data-y')) || 0);

    // update the element's style
    target.style.width  = event.rect.width + 'px';
    target.style.height = event.rect.height + 'px';

    // translate when resizing from top or left edges
    x += event.deltaRect.left;
    y += event.deltaRect.top;

    target.style.webkitTransform = target.style.transform =
        'translate(' + x + 'px,' + y + 'px)';

    target.setAttribute('data-x', x);
    target.setAttribute('data-y', y);

    target.textContent = Math.round(event.rect.width / 30) + "m" + ' x ' + Math.round(event.rect.height / 30) + "m" ;


    document.getElementById("largeur").value = castPixelsToMeters(target.style.width);
    document.getElementById("longueur").value = castPixelsToMeters(target.style.height);

  });






