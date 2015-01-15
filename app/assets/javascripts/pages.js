$(document).ready(function() {
    $('#simple-menu').sidr({
      side: 'right',
      displace: false,
      speed: 300
      });
  });

$(document).ready(function() {
   var stickyNavTop = $('.nav').offset().top;

   var stickyNav = function(){
     var scrollTop = $(window).scrollTop();

     if (scrollTop > stickyNavTop) {
           $('.nav').addClass('sticky');
     } else {
           $('.nav').removeClass('sticky');
     }
   };

   stickyNav();

   $(window).scroll(function() {
         stickyNav();
   });
 });


