function get_id(clicked_id) {
  Shiny.setInputValue("records-current_id", clicked_id, {priority: "event"});
}

shinyjs.init = function() {
  // copyrights:
  document.getElementById('year').innerHTML = new Date().getFullYear();
  
  // faders:
  const faders = document.querySelectorAll('.fade-in');

  const appearOptions = {
    threshold: 0, 
    rootMargin: '0px 0px -250px 0px'
  };

  // observer:
  const appearOnScroll = new IntersectionObserver(function(entries, appearOnScroll) {
    entries.forEach(entry => {
      if (!entry.isIntersecting) {
        return;
      } else {
        entry.target.classList.add('appear');
        appearOnScroll.unobserve(entry.target);
      }
  })
  }, appearOptions);

  faders.forEach(fader => {
    appearOnScroll.observe(fader);
  })
}
