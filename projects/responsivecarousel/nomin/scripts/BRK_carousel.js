//	PLUGIN -- BRK_Carousel

(function( document, window, undefined ){

window.brk = window.brk || {};

brk.carousel = BRK_carousel;




//	Functions

function BRK_carousel ( options ) { // CLOSURE BEGIN -- setCarousel

//	Variables
//	 - Simulation data
var w = 200;
var n = 10;
var i = 0;

//	 - Element class names
var carousel_class = 'carousel';
var viewFinder_class = 'viewFinder';
var film_class = 'film';
var item_class = 'item';
var itemFocus_class = 'item--focused';

//	 - DOM Elements
//	The container for all of the carousel parts.
var carousel_elt = document.querySelector( '.' + carousel_class );
//	A box the same size as an item which is always
//		in the same position as the current item.
var viewFinder_elt = carousel_elt.querySelector( '.' + viewFinder_class );
//	The container element for all of the items.
//	This film is 'threaded' through the viewfinder.
var film_elt = viewFinder_elt.querySelector( '.' + film_class );
//	The items.
var item_elts = film_elt.querySelectorAll( '.' + item_class );

setActiveClass();
viewFinder_elt.style.width = w + 'px';
film_elt.style.width       = ( w*n ) + 'px';
Array.prototype.forEach.call( item_elts, function ( item_elt ) {
	item_elt.style.width = w + 'px';
});


//	Return
return {
	inc: incrementBy.bind( null, false ),

	next: function(){
		incrementBy( false, 1 );
	},

	prev: function(){
		incrementBy( false, -1 );
	},

	goto: incrementBy.bind( null, true ),

	get: {
		pos: function(){ return i }
	}
}

//	Functions
function incrementBy ( explicit, x ) {
	removeActiveClass();

	//  Make sure X is an integer
	x = parseInt( x, 10 );

	//	Increment the film as desired
	if ( explicit ) {
		i = x;
	} else {
		i += x;
	}

	settlePosition();

	//	Move the film elements to their new positions
	renderFilm();
}

function settlePosition () {
	//	HACK: There MUST be a better way of doing this...
	//	Make sure the position is positive
	while ( i < 0 ) {
		i += n;
	}

	//	Make sure the number isn't too big
	i = i%n;
}

//	Style the film elements to represent the data
function renderFilm () {
	setActiveClass();

	film_elt.style.left = -( i*w ) + 'px';

	viewFinder_elt.style.left = ( i*( 1/( n - 1 ) ) )*100 + '%';
	viewFinder_elt.style.marginLeft = -( i*( 1/( n - 1 ) ) )*w + 'px';
}

//	Remove the active class from all items
function removeActiveClass () {
	Array.prototype.forEach.call(
		film_elt.querySelectorAll( '.' + itemFocus_class ),
		function ( item_elt ) {
			item_elt.classList.remove( itemFocus_class );
		}
	);
}

//	Add the active class to the currently active item
function setActiveClass () {
	item_elts[ i ].classList.add( itemFocus_class );
}

} // CLOSURE END -- setCarousel







}( document, window ));