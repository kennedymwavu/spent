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
  
  // scroll to top btn:
  let btnScrollTop = document.getElementById('back_to_top');
  
  // when user scrolls 20px from top of document, show the btn:
  window.onscroll = function() {
    scrollFunction();
  }
  
  function scrollFunction() {
    if (
      document.body.scrollTop > 20 || 
      document.documentElement.scrollTop > 20
    ) {
      btnScrollTop.style.display = 'block';
    }else {
      btnScrollTop.style.display = 'none';
    }
  }
  
  // when user clicks on the btn, scroll to top of document:
  btnScrollTop.addEventListener('click', backToTop);
  
  function backToTop() {
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
  }
}
