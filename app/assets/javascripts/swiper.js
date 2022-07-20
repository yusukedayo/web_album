document.addEventListener('DOMContentLoaded', function() { 
  const mySwiper = new Swiper('.mySwiper', {
  // Optional parameters
  loop: true,
  loopAdditionalSlides: 1,
  //アニメーションで動くように設定
  speed: 700,
  autoplay: {
    delay: 2000,
    disableOnInteraction: false,
  },

  watchSlidesProgress: true,

  // Navigation arrows
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },
  slidesPerView: 1.35,
  breakpoints: {
    // スライドの表示枚数：500px以上の場合
    500: {
      slidesPerView: 2.75,
    },
  },
  spaceBetween: 30,
  centeredSlides: true,
  pagination: {
    el: ".swiper-pagination",
    clickable: true,
  },
  })
});

document.addEventListener('DOMContentLoaded', function() { 
  const loopSwiper = new Swiper('.loopSwiper', {
  spaceBetween: 5,
  loop: true, // ループ有効
  slidesPerView: 2,
  breakpoints: {
    // スライドの表示枚数：500px以上の場合
    500: {
      slidesPerView: 3,
    },
    700: {
      slidesPerView: 4,
    },
    900: {
      slidesPerView: 5,
    },
    1100: {
      slidesPerView: 6,
    }
  },
  speed: 8000, // ループの時間
  allowTouchMove: false, // スワイプ無効
  autoplay: {
    delay: 0, // 途切れなくループ
  },
});
});
