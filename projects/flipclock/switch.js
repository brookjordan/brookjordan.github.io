(function(){

var style = document.getElementById( 'style' );
var buttons = document.querySelectorAll( 'button' );
var switchFuncs = [];
var i;



for ( i=0; i<buttons.length; ++i ) {

	switchFuncs.push( buildStyleSwitch( buttons[i] ) );

	buttons[i].addEventListener( 'click', switchFuncs[i], false );

}



function buildStyleSwitch ( elt ) {
	return function ( e ) {
		for ( i=0; i<buttons.length; ++i ) {
			buttons[i].className = '';
		}

		elt.className = 'active';
		style.href = elt.id + '.css';
	}
}

}());