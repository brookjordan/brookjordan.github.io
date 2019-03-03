'use strict';
var pagesData = [{
        title: 'Inventory',
        image: 'https://s3-us-west-2.amazonaws.com/s.cdpn.io/291020/inventory.jpg'
    }];
var sectionTab_elts = document.querySelectorAll('.tab-set__tab');
Array.prototype.forEach.call(sectionTab_elts, function (tabElt) {
    tabElt.addEventListener('click', function (e) {
        var sibling_elts = tabElt.parentNode.querySelectorAll('.tab-set__tab');
        if (sibling_elts.length - 1) {
            Array.prototype.forEach.call(sibling_elts, function (tabElt) {
                tabElt.classList.remove('tab-set__tab--active');
            });
            tabElt.classList.add('tab-set__tab--active');
        }
    });
});
var sectionTitle_elt = document.querySelector('.section__title');
var appNav_elt = document.querySelector('.app-nav');
sectionTitle_elt.addEventListener('click', function (e) {
    appNav_elt.classList.toggle('app-nav--open');
});
var navHead_elt = document.querySelector('.nav_head');
var section_elt = document.querySelector('.section');
navHead_elt.addEventListener('click', function (e) {
    section_elt.classList.toggle('section--footer-menu-has-content');
});
var floatMenu_elt = document.querySelector('.float-menu');
var placeholderImage_elt = document.querySelector('.placeholder_image');
var sectionBody_elt = document.querySelector('.section-content__body');
var floatingMenuOpennessPadding = 100;
setFloatingMenuOpenness();
sectionBody_elt.addEventListener('scroll', setFloatingMenuOpenness);
function setFloatingMenuOpenness() {
    var sectionScroll = sectionBody_elt.scrollTop;
    if (sectionScroll < floatingMenuOpennessPadding) {
        addOpenClass();
    } else {
        var imgHeight = placeholderImage_elt.getBoundingClientRect().height;
        var sectionHeight = sectionBody_elt.getBoundingClientRect().height;
        if (imgHeight - sectionHeight - sectionScroll - floatingMenuOpennessPadding <= 0) {
            addOpenClass();
        } else {
            floatMenu_elt.classList.remove('float-menu--open');
        }
    }
    function addOpenClass() {
        floatMenu_elt.classList.add('float-menu--open');
    }
}