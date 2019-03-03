//	DEMO
//
var c = brk.carousel();

var frst_elt = document.querySelector( '.frst' );
var rwnd_elt = document.querySelector( '.rwnd' );
var prev_elt = document.querySelector( '.prev' );
var next_elt = document.querySelector( '.next' );
var ffwd_elt = document.querySelector( '.ffwd' );
var last_elt = document.querySelector( '.last' );



frst_elt.addEventListener( 'click', function(){
	c.goto( 0 )
}, false );
rwnd_elt.addEventListener( 'click', function(){
	c.inc( -2 )
}, false );
prev_elt.addEventListener( 'click', c.prev, false );

next_elt.addEventListener( 'click', c.next, false );
ffwd_elt.addEventListener( 'click', function(){
	c.inc( 2 )
}, false );
last_elt.addEventListener( 'click', function(){
	c.goto( 9 )
}, false );