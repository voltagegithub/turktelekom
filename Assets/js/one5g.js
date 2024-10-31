//----------tkn-5G kısmındaki slider------------
$owlSpec = $('.g-spec .owl-carousel').owlCarousel({
    loop: false,
    lazyLoad: true,
    margin: 10,
    autoplay: false,
    autoplayHoverPause: false,
    dotsContainer: '#carousel-custom-dots',
    nav: false,
    responsive: {
        0: {
            items: 1
        },
        600: {
            items: 1
        },
        1000: {
            items: 1
        }
    }
});


$('.owl-dot:first').addClass('active');
$('.owl-dot').click(function () {
    $owlSpec.trigger('to.owl.carousel', [$(this).index(), 300]);
    $('.owl-dot').removeClass('active');
    $(this).addClass('active');
});

$owlSpec.on('changed.owl.carousel', function (event) {
    $('.owl-dot').removeClass('active');
    $('.owl-dot:eq(' + event.item.index + ')').addClass('active')
});

$owlSettings = $('.device-settings .owl-carousel').owlCarousel({
    loop: false,
    lazyLoad: true,
    margin: 2,
    autoplay: false,
    autoplayHoverPause: false,
    dots: false,
    nav: true,
    navContainerClass: 'slider-controller',
    responsive: {
        0: {
            items: 1,
            dots: true,
            dotsContainer: '.slider-dots',
            dotsData: true
        },
        600: {
            items: 1,
            dots: true,
            dotsContainer: '.slider-dots',
            dotsData: true
        },
        1000: {
            items: 1
        }
    }
});
$owlSettings.on('changed.owl.carousel', function (event) {
    $(".number-list li.active").removeClass("active");
    $(".number-list").each(function () {
        $(this).find("li").eq(event.item.index).addClass("active");
    });
    if (event.item.index > 0) {
        $(".settings-slider .owl-prev").removeClass("passive");
    } else {
        $(".settings-slider .owl-prev").addClass("passive");
    }
    if (event.item.index == (event.item.count - 1)) {
        $(".settings-slider .owl-next").addClass("passive");
    } else {
        $(".settings-slider .owl-next").removeClass("passive");
    }

});

$(".my-button").click(function () {
    $([document.documentElement, document.body]).animate({
        scrollTop: $("#hazir-misiniz").offset().top
    }, 1000);
});


//-----------#a-ulke kısmındaki butonu aktifleştirir-----------------
let deviceSelect = document.querySelector('.country');
let selectTexts = document.querySelectorAll('.select-text');

deviceSelect.addEventListener('change', (event) => {
    const selectedValue = event.target.value;

    selectTexts.forEach(selectText => {
        if (selectText.getAttribute('data-value') === selectedValue) {
            selectText.style.display = 'block';
        } else {
            selectText.style.display = 'none';
        }
    });
});


//-----------#accordion kısmındaki h3 içerisindeki soruları p içerisindeki gösterme işlemini yapar-------------
document.addEventListener("DOMContentLoaded", function () {
    const accordionItems = document.querySelectorAll(".accordion__item");

    accordionItems.forEach(item => {
        const title = item.querySelector("h3");
        const content = item.querySelector("p");

        title.addEventListener("click", () => {
            const isExpanded = content.classList.contains("show");

            accordionItems.forEach(otherItem => {
                const otherContent = otherItem.querySelector("p");
                otherContent.classList.remove("show");
            });

            accordionItems.forEach(otherItem => {
                const otherTitle = otherItem.querySelector("h3");
                const otherTitles = otherItem.querySelector("p");
                otherTitle.classList.remove("active");
            });

            if (!isExpanded) {
                content.classList.add("show");
                title.classList.add("active");
            }
        });
    });
});

//h3 aktifleşince oklar değişiyor. aktifken bile başka h3e geçtiğinde de diğeri aktif olmuyor
document.addEventListener("DOMContentLoaded", function () {
    const accordionTitles = document.querySelectorAll(".accordion__item h3");

    accordionTitles.forEach(title => {
        title.addEventListener("click", function (event) {
            const accordionItems = document.querySelectorAll(".accordion__item");
            const parentItem = this.parentElement;
            const isActive = parentItem.classList.contains("active");
            
            accordionItems.forEach(item => {
                item.classList.remove("active");
            });

            if (!isActive) {
                parentItem.classList.add("active");
            }

            accordionItems.forEach(item => {
                const iconChevronDown = item.querySelector(".icon-chevron-down img");
                if (item === parentItem && item.classList.contains("active")) {
                    iconChevronDown.src = "assets/img/up-ok.svg";
                    iconChevronDown.alt = "Up Arrow";
                    iconChevronDown.style.transform = "rotate(90deg)";
                } else {
                    iconChevronDown.src = "assets/img/down-ok.svg";
                    iconChevronDown.alt = "Down Arrow";
                    iconChevronDown.style.transform = "rotate(0deg)";
                }
            });

            event.stopPropagation();
        });
    });
});



//---------Navbarı scroll ettiğimizde rengini değiştirir-------------
function scrollToTarget(targetId) {
    const targetElement = document.getElementById(targetId);
    if (targetElement) {
        targetElement.scrollIntoView({ behavior: "smooth" });
    }
}
const navbar = document.querySelector('.nav');
const navLinks= navbar.querySelectorAll('li a');

window.addEventListener('scroll', () => {
    if (window.scrollY > 40) {
        navbar.classList.add('scrolled');
    } else {
        navbar.classList.remove('scrolled');
    }
});

navLinks.forEach(navLink=>{
    navLink.addEventListener('click',function(){
        document.querySelector('.nav li a.active')?.classList.remove('active');
        navLink.classList.add('active');
    })
});

const image = [
    "/assets/img/TT-siyah-228x43.svg"
];

const dynamicImage = document.getElementById('dynamic-image');
const pictureContainer = document.querySelector('.logo picture'); 
const targetSectionId = "ozellik-5g";
const targetSection = document.getElementById(targetSectionId);
let isVisible = false;

// Pencere kaydırma 
window.addEventListener('scroll', () => {
    if (window.scrollY > 40) {
        if (!isVisible) {
            dynamicImage.style.display = 'block'; 
            pictureContainer.style.display = 'none';
            document.querySelector(".nav").classList.add("black-nav"); 
            isVisible = true;
        }
        
        const targetSectionTop = targetSection.getBoundingClientRect().top;
        const currentImageIndex = Math.floor(Math.abs(targetSectionTop) / 200); 
        if (currentImageIndex < image.length) {
            dynamicImage.src = image[currentImageIndex];
        }
    } else {
        if (isVisible) {
            dynamicImage.style.display = 'none'; 
            pictureContainer.style.display = 'block'; 
            isVisible = false;
            document.querySelector(".nav").classList.remove("black-nav");
        }
        dynamicImage.src = image[0]; 
    }
});


function updateActiveLink() {
    var scrollPosition = $(window).scrollTop() + 400;
    var sections = document.querySelectorAll('section');
    var links = document.querySelectorAll('.links a');

    var bannerTop = $('#main-banner').offset().top;
    if (scrollPosition < bannerTop) {
        $('.links a').removeClass('active');
        $('.links a[href="#main-banner"]').addClass('active');
        return;
    }

    for (var i = sections.length - 1; i >= 0; i--) {
        var sectionTop = sections[i].offsetTop;
        if (sectionTop <= scrollPosition) {
            var sectionId = sections[i].getAttribute('id');
            $('.links a').removeClass('active');
            $('.links a[href="#' + sectionId + '"]').addClass('active');
            break;
        }
    }
}

$(document).ready(function() {
    updateActiveLink(); 
    $(window).scroll(updateActiveLink); 
    $(window).resize(updateActiveLink); 
});

//---------#km-tası kısmındaki içeriklerin yıllara göre aktifleşmesi----------
showContent("2023");
const yearItems = document.querySelectorAll('.date .item');
yearItems.forEach((item, index, arr) => {
    item.addEventListener('click', () => {
        document.querySelector('.date .item.active').classList.remove('active');
        const year = item.querySelector('span:last-child').textContent;
        showContent(year);
        item.classList.add('active')
    });
});

// İstenilen yıla ait içerikleri gösteren fonksiyon
function showContent(year) {
    const textBoxes = document.querySelectorAll('.textbox');
    textBoxes.forEach(textBox => {
        const dataDt = textBox.getAttribute('data-dt');
        if (dataDt === year) {
            textBox.style.display = 'flex';

        } else {
            textBox.style.display = 'none';
        }
    });
}

//----------#cihazdaki butonların aktişleşmesini sağlar----------
function addButtonListeners(buttons, contentContainer) {
    buttons.forEach(button => {
      button.addEventListener('click', () => {
        const isActive = button.classList.contains('active');
        buttons.forEach(btn => {
          btn.classList.remove('active');
        });
  
        if (!isActive) {
          buttons.forEach(btn => btn.classList.remove('active'));
          button.classList.add('active');
          contentContainer.style.display = 'block';
  
          const value = button.getAttribute('data-value');
          const activeContent = document.querySelector(`.${contentContainer.className} .d-device#${value}`);
  
          document.querySelectorAll(`.${contentContainer.className} .d-device`).forEach(content => {
            if (content === activeContent) {
              content.style.display = 'block';
            } else {
              content.style.display = 'none';
            }
          });
        } else {
          button.classList.remove('active');
          contentContainer.style.display = 'none';
        }
      });
    });
  }
 
  const buttonsSec = document.querySelectorAll('.sec .brand-button');
  const contentContainerSec = document.querySelector('.sec .content-container');
  
  addButtonListeners(buttonsSec, contentContainerSec);
  
  const buttonsSec1 = document.querySelectorAll('.sec1 .brand-button');
  const contentContainerSec1 = document.querySelector('.sec1 .content-container');
  
  addButtonListeners(buttonsSec1, contentContainerSec1);