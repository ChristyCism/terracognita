import interact from 'interactjs'

interact('.tap-target')
  .on('tap', function (event) {
    event.currentTarget.classList.toggle('rotate');
    event.preventDefault();
  });


// 'rotate(' + 90 + 'deg)';
