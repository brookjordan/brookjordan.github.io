(function(){


var clock = document.getElementById( 'clock' );
var numbers = [
	[ 1,1,1,1,0,1,1,0,1,1,0,1,1,1,1 ],	//	0
	[ 1,1,0,0,1,0,0,1,0,0,1,0,1,1,1 ],	//	1
	[ 1,1,1,0,0,1,0,1,1,1,0,0,1,1,1 ],	//	2
	[ 1,1,1,0,0,1,0,1,1,0,0,1,1,1,1 ],	//	3
	[ 1,0,1,1,0,1,1,1,1,0,0,1,0,0,1 ],	//	4
	[ 1,1,1,1,0,0,1,1,1,0,0,1,1,1,1 ],	//	5
	[ 1,1,1,1,0,0,1,1,1,1,0,1,1,1,1 ],	//	6
	[ 1,1,1,0,0,1,0,0,1,0,1,0,0,1,0 ],	//	7
	[ 1,1,1,1,0,1,1,1,1,1,0,1,1,1,1 ],	//	8
	[ 1,1,1,1,0,1,1,1,1,0,0,1,0,0,1 ],	//	9
	[ 0,0,0,0,1,0,0,0,0,0,1,0,0,0,0 ],	//	: / 10
	[ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ],	//	  / 11
];
var hour_ten = createDigit();
var hour_unit = createDigit();
var hour_min = createDigit();
var min_ten = createDigit();
var min_unit = createDigit();
var min_sec = createDigit();
var sec_ten = createDigit();
var sec_unit = createDigit();
var num = 0;

setTimeout( setColons, 4 );

setInterval(function(){
	changeTime();
}, 500);

//	Functions

function createDigit () {
	var i;
	var piece;
	var pieces = [];
	var digit = document.createElement( 'div' );

	digit.className = 'digit';

	for ( i=0; i<15; i+=1 ) {
		piece = document.createElement( 'div' );
		piece.className = 'digit__piece digit__piece-' + i + ' digit__piece--off';
		digit.appendChild( piece );

		pieces.push( piece );
	}
	pieces.push( digit );

	clock.appendChild( digit );

	return pieces;

}

function switchPiece ( digit, piece, state ) {
	if ( !!state ) {
		digit[ piece ].classList.remove( 'digit__piece--off' );
		digit[ piece ].classList.add( 'digit__piece--on' );
	} else {
		digit[ piece ].classList.remove( 'digit__piece--on' );
		digit[ piece ].classList.add( 'digit__piece--off' );
	}
}

function switchDigit ( digit, number ) {
	var i;

	digit[ digit.length-1 ].className = 'digit digit-' + number;

	for ( i=0; i<15; ++i ) {
		switchPiece( digit, i, numbers[ number ][ i ] );
	}
}

function setColons ( digit, number ) {
	switchDigit( hour_min, 10 );
	switchDigit( min_sec, 10 );
}

function changeTime () {
	var date  = new Date();
	var hours = pad( date.getHours()   ).split( '' );
	var mins  = pad( date.getMinutes() ).split( '' );
	var secs  = pad( date.getSeconds() ).split( '' );
	var ms    = pad( date.getMilliseconds() ).split( '' );

	switchDigit( hour_ten,  +hours[0] );
	switchDigit( hour_unit, +hours[1] );

	switchDigit( hour_min,  +secs[1]%2 ? 10 : 11 );

	switchDigit( min_ten,   +mins[0] );
	switchDigit( min_unit,  +mins[1] );

	switchDigit( min_sec,   +secs[1]%2 ? 10 : 11 );

	switchDigit( sec_ten,   +secs[0] );
	switchDigit( sec_unit,  +secs[1] );
}

function pad ( n ) {
	n = n + '';
	return n.length >= 2 ? n : new Array(2 - n.length + 1).join('0') + n;
}


}());