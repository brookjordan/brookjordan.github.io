(function( document, window, ng, undefined ){'use strict';


ng.module('brk', []);


})( document, window, angular );
(function( document, window, ng, undefined ){
'use strict';

var pointerover;
var pointerout;
var pointerdown;
var pointerup;
var pointercancel;

var isTouch = (function () {
	try {
		document.createEvent( 'TouchEvent' );

		pointerover		= 'touchstart';
		pointerout		= 'touchend';
		pointerdown		= 'touchstart';
		pointerup		= 'touchend';
		pointercancel	= 'touchcancel';
		return true;

	} catch (e) {
		pointerover		= 'mouseover';
		pointerout		= 'mouseout';
		pointerdown		= 'mousedown';
		pointerup		= 'mouseup';
		pointercancel	= 'mouseup';
		return false;
	}
}());





ng.module('brk')

.directive( 'brkClass', [function(){
	var brkClass = {};

	brkClass.controller = 'BrkClassController';
	brkClass.scope = {
		'baseClass': '@brkClass',
		'over': '@?',
		'down': '@?'
	}

	return brkClass;
}])

.controller( 'BrkClassController', [ '$scope', '$element', '$document', '$timeout',
	function( $scope, $element, $document, $timeout ){

	//	When a pointerover happens,
	//		check if the class tried to be removed.
	//	If it did, cancel the removal.
	//	When a pointerout happens,
	//		add a small delay before removing the class.
	//		this is to allow the pointerover to
	//		cancel the class removal
	//	These events do nothing on mobile:
	//		everything is delegated to pointer down
	function mouseoverHandler ( e ) {
		e.preventDefault();

		addOver();
		if ( removeHover ) {
			$timeout.cancel( removeHover );
			removeHover = false;
		}
	}
	function mouseoutHandler ( e ) {
		removeHover = $timeout( removeOver, 4 );
	}

	//	On mobile we add hover and pointerdown states
	//		on touchstart, removing both on touchend
	function mousedownHandler ( e ) {
		e.preventDefault();

		addDown();
		if ( isTouch ) {
			addOver();
			$element.on( pointerup, pointerupHandler );
			$element.on( pointercancel, pointerupHandler );

		} else {
			$document.on( pointerup, pointerupHandler );
		}

	}
	function pointerupHandler ( e ) {
		if ( isTouch ) {
			$element.off( pointerup, pointerupHandler );
			$element.off( pointercancel, pointerupHandler );
			removeOver();

		} else {
			$document.off( pointerup, pointerupHandler );
		}

		removeDown();
	}

	//	On mobile we add hover and pointerdown states
	//		on touchstart, removing both on touchend
	function touchstartHandler ( e ) {
		e.preventDefault();

		addDown();
		addOver();

	}
	function touchendHandler ( e ) {
		removeOver();
		removeDown();
	}

	//	Add the '--over' class
	function addOver () {
		setClass( 'over', true );
	}
	//	Remove the '--over' class
	function removeOver () {
		setClass( 'over', false );
	}
	//	Add the '--active' class
	function addDown () {
		setClass( 'down', true );
	}
	//	Remove the '--active' class
	function removeDown () {
		setClass( 'down', false );
	}

	function setClass ( which, whichTo ) {
		var oldOver = state.over;
		var oldDown = state.down;
		state[ which ] = whichTo;

		//	Sorting the '--overdown' class
		if ( state.over && state.down ) {
			if ( !oldOver || !oldDown ) {
				$element.addClass( overDownClass );
			}
		} else {
			if ( oldOver && oldDown ) {
				$element.removeClass( overDownClass );
			}
		}

		//	Sorting the '--over' class
		if ( state.over ) {
			if ( !oldOver ) {
				$element.addClass( overClass );
			}
		} else {
			if ( oldOver ) {
				$element.removeClass( overClass );
			}
		}

		//	Sorting the '--down' class
		if ( state.down ) {
			if ( !oldDown ) {
				$element.addClass( downClass );
			}
		} else {
			if ( oldDown ) {
				$element.removeClass( downClass );
			}
		}
	}

	var overName = $scope.over || 'over';
	var downName = $scope.down || 'down';
	var baseClass = $scope.baseClass;
	var overClass = baseClass + '--' + overName;
	var downClass = baseClass + '--' + downName;
	var overDownClass = baseClass + '--' + overName + downName;
	var removeHover = false;
	var state = {
		over: false,
		down: false
	};

	$element.addClass( $scope.baseClass );

	//if ( isTouch ) {
		$element.on( 'touchstart', touchstartHandler );
		$element.on( 'touchend', touchendHandler );
		$element.on( 'touchcancel', touchendHandler );
	//} else {
		$element.on( 'mouseover', mouseoverHandler );
		$element.on( 'mouseout', mouseoutHandler );
		$element.on( 'mousedown', mousedownHandler );
	//}

}])

.directive('brkTouchstart', [function() {
    return function(scope, element, attr) {

        element.on('touchstart', function(event) {
            scope.$apply(function() {
                scope.$eval(attr.brkTouchstart);
            });
        });
    };
}]).directive('brkTouchend', [function() {
    return function(scope, element, attr) {

        element.on('touchend', function(event) {
            scope.$apply(function() {
                scope.$eval(attr.brkTouchend);
            });
        });
    };
}]);



})( document, window, angular );
(function( document, window, ng, undefined ){'use strict';



ng.module('brk')

.factory('brkID', [ '$filter', function( $filter ){
	//	Memo the last created ID.
	//	I don't think incrementing an ID from
	//		0 will ever be an issue.
	//	That said, I will try not to make anything
	//		depend on a zero-based ID system as I
	//		may change this to a hash ID system later.
	function getNewID ( type, options ) {
		var o = options || {};
		o.type = type || '';
		o.index = IDs.length;
		o.ID = $filter( 'brkSha256' )( o.type + '_' + o.index + '_' + Math.random() + '_' + (+new Date()) );

		IDs.push( o );

		return ( o.ID );
	}

	function getIDData ( ID ) {
		var i = 0;

		for (; i<IDs.length; i+=1 ) {
			if ( IDs[i].ID === ID ) {
				return IDs[ i ];
			}
		}

		return undefined;
	}



	var brkID = {};
	var IDs = [];



	brkID.generate = getNewID;
	brkID.get = getIDData;



	return brkID;

	//	Depends on:
	//	 -	brkSha256
}]);



})( document, window, angular );
(function( document, window, ng, undefined ){'use strict';

ng.module('brk')

.factory('brkMenu', [ 'brkID', function( brkID ){


	function Menu ( options ) {
		var defaultOptions = {
			name		:	'',
			title		:	'',
			description	:	'',
			url			:	''
		}
		var	o = ng.extend( {}, defaultOptions, options );


		/*		Useful Properties		*/
		this.parent			=	o.parent;
		this.ID				=	brkID.generate( 'brkMenu' );
		this.name			=	o.name;
		this.path			=	o.path;
		this.route			=	o.path.split('/');
		this.level			=	this.route.length;
		this.rootName		=	this.level > 1 ?
									brkMenu.get( this.route[0] ) :
									this;
		this.root			=	brkMenu.get( this.route[0] ) || this;
		this.nav			=	[];
		this.is = {
			visible:	typeof o.visible === 'boolean' ?
				o.visible :
				true,

			open:		typeof o.open === 'boolean' ?
				o.open :
				false
		};
		this.links = {};

		/*		Text only Properties		*/
		this.title			=	o.title;
		this.description	=	o.description;
		this.url			=	o.url;


		/*		Methods		*/
		this.add		=	addMenu.bind( undefined, this );
		this.remove		=	removeMenu.bind( undefined, this );
		this.get		=	getMenu.bind( undefined, this );
		this.toggle		=	toggleMenu.bind( undefined, this );
		this.link		=	function ( otherMenus, linkType, state ) {
			linkMenus( [this].concat( otherMenus ), linkType, state );
		};
		this.unlink		=	unlinkMenus.bind( undefined, this);

		/*		Contrived Methods		*/
		this.toggleOpen	=	toggleMenu.bind( undefined, this, 'open' );
		this.open		=	toggleMenu.bind( undefined, this, 'open', true );
		this.close		=	toggleMenu.bind( undefined, this, 'open', false );

		this.toggleShow	=	toggleMenu.bind( undefined, this, 'visible' );
		this.show		=	toggleMenu.bind( undefined, this, 'visible', true );
		this.hide		=	toggleMenu.bind( undefined, this, 'visible', false );

	}


	function addMenu ( menuToAddTo, options ) {
		//	The reason the menuToAddTo parameter has been
		//		added is to hopefully make this function
		//		more modular/testable.
		var defaultOptions	=	{ name: '' };
		var menuSet			=	menuToAddTo.nav;
		var nameIsUnique	=	true;
		var i;
		var o;
		var presetOptions;
		var addedMenu;

		if ( !/\//.test( options.name ) ) {
			o				=	ng.extend( defaultOptions, options );
			presetOptions	=	{
				path: menuToAddTo.path ?
					menuToAddTo.path + '/' + o.name :
					o.name,
				parent: menuToAddTo
			}
			ng.extend( o, presetOptions );

			//	We need to list through the siblings
			//		in order to find out if this name is
			//		unique. We don't add it if it's not.
			for ( i = 0; i < menuSet.length; i += 1 ) {
				if ( menuSet[i].name === o.name ) {
					nameIsUnique = false;

					break;
				}
			}

			//	See? Won't add it.
			if ( nameIsUnique ) {
				addedMenu = new Menu(o);
				initialiseState( addedMenu );

				menuSet.push( addedMenu );
			}
		}


		//	Return the original menu to allow chaining
		return menuToAddTo;

	}

	function initialiseState ( menu ) {
		var initialStateData = initialStates[ menu.path ];
		var i;

		if ( initialStateData ) {
			//	Check initial states object
			//		to see if this menu needs initialising
			for ( i in initialStateData ) {
				menu.toggle( i, initialStateData[i] );
			}
			//	No longer needed
			delete initialStates[ menu.path ];
		}
	}


	function toggleMenu ( menu, state ) {
		var oldState	=	menu.is[ state ];
		var newState;
		var foundState	=	false;

		var linkIteration;
		var i = 0;

		for (; i<arguments.length; i+=1 ) {
			if ( typeof arguments[i] === 'boolean' ) {
				newState = arguments[i];
				foundState = true;
			}
			if ( ng.isNumber( arguments[i] ) ) {
				linkIteration = arguments[i];
			}
		}

		if ( !foundState ) {
			newState = !menu.is[ state ] ;
		}

		linkIteration = linkIteration || 0;

		if ( linkIteration < settings.maxLinkIterations ) {
			menu.is[ state ] = newState;
			runLinks( menu, state );
		}

		return menu;
	}


	function linkMenus ( menus, linkType, state ) {
		var linkID = brkID.generate( 'brkMenu__link' );
		var link;
		var i = 0;

		linkID = brkID.generate( 'brkMenu__link' );
		link = {
			menus: menus,
			state: state,
			type: linkType
		};

		for (; i<menus.length; i+=1 ) {
			menus[i].links[ state ] = menus[i].links[ state ] || [];
			menus[i].links[ state ].push( linkID );
		}

		menuLinks[ linkID ] = link;

		return menus[0];
	}


	function runLinks ( menu, state, linkIteration ) {
		var i			=	0;
		var linkIDs		=	menu.links[ state ];
		var linkID;

		if ( linkIDs && linkIDs.length ) {
			for (; i<linkIDs.length; i+=1 ) {
				linkID = linkIDs[i];

				runLink( menu, linkID, linkIteration );
			}
		}
	}


	function runLink ( menuA, linkID, linkIteration ) {
		var link = menuLinks[ linkID ];
		menuA = menuA || link[ menus ][0];
		var otherMenus = getOtherMenusFromLink( menuA, link );

		switch ( link.type ) {
			case 'exactly one is':
				runOneIsLink( menuA, otherMenus, link, linkIteration, true );
				break;

			case 'one is':
				runOneIsLink( menuA, otherMenus, link, linkIteration );
				break;

			case 'exactly one not':
				runOneNotLink( menuA, otherMenus, link, linkIteration, true );
				break;

			case 'one not':
				runOneNotLink( menuA, otherMenus, link, linkIteration );
				break;

			case 'one each':
				runOneEachLink( menuA, otherMenus, link, linkIteration );
				break;

			default:
				return brkMenu;
		}
	}
	function runOneIsLink ( menuA, otherMenus, link, linkIteration, exactly ) {
		var menuB;
		var i;
		var state = link.state;
		var oneIs = false;

		exactly = typeof exactly === 'boolean' ?
			exactly :
			false;

		if ( menuA.is[ state ] ) {
			for ( i=0; i<otherMenus.length; i+=1 ) {
				menuB = otherMenus[i];

				if ( menuB.is[ state ] ) {
					menuB.toggle( state, linkIteration+1, false );
				}
			}

		} else {
			for ( i=0; i<otherMenus.length; i+=1 ) {
				menuB = otherMenus[i];

				if ( menuB.is[ state ] ) {
					if ( oneIs ) {
						menuB.toggle( state, linkIteration+1, false );
					} else {
						oneIs = true;
					}
				}
			}

			if ( exactly && !oneIs ) {
				menuA.toggle( state, linkIteration+1, true );
			}
		}
	}
	function runOneNotLink ( menuA, otherMenus, link, linkIteration, exactly ) {
		var menuB;
		var i;
		var state = link.state;
		var oneIsnt = false;

		exactly = typeof exactly === 'boolean' ?
			exactly :
			false;

		if ( !menuA.is[ state ] ) {
			for ( i = 0; i<otherMenus.length; i+=1 ) {
				menuB = otherMenus[i];

				if ( !menuB.is[ state ] ) {
					menuB.toggle( state, linkIteration+1, true );
				}
			}
		} else {
			for ( i=0; i<otherMenus.length; i+=1 ) {
				menuB = otherMenus[i];

				if ( !menuB.is[ state ] ) {
					if ( oneIsnt ) {
						menuB.toggle( state, linkIteration+1, true );
					} else {
						oneIsnt = true;
					}
				}
			}

			if ( exactly && !oneIsnt ) {
				menuA.toggle( state, linkIteration+1, false );
			}
		}
	}
	function runOneEachLink ( menuA, otherMenus, link, linkIteration ) {
		if ( menuA.is[ link.state ] === menuB.is[ link.state ] ) {
			menuB.toggle( link.state, linkIteration+1 );
		}
	}

	function getMenuBFromLink ( menuA, link ) {
		var menuAIndex = link.menus.indexOf( menuA );
		var menuB = link.menus[ Math.abs( menuAIndex-1 ) ];

		return menuB;
	}
	function getOtherMenusFromLink ( menuA, link ) {
		var otherMenus	= [];
		var i = 0;

		for (; i<link.menus.length; i+=1 ) {
			if ( link.menus[i] !== menuA ) {
				otherMenus.push( link.menus[i] );
			}
		}

		return otherMenus;
	}


	function unlinkMenus ( menuA ) {
		var menuB, checkingState, i, j;
		var menuALinkIDs, menuALinkID, menuALink;
		var menuBLinkIDs, menuBLinkID;
		var linkIndex;

		for ( checkingState in menuA.links ) {
			menuALinkIDs = menuA.links[ checkingState ];

			for ( i = menuALinkIDs.length-1; i >= 0; i-=1 ) {
				menuALinkID = menuALinkIDs[i];
				menuALink = menuLinks[ menuALinkID ];
				menuB = getMenuBFromLink( menuA, menuALink );
				menuBLinkIDs = menuB.links[ checkingState ];

				for ( j = menuBLinkIDs.length-1; j >= 0; j-=1 ) {
					menuBLinkID = menuB.links[ checkingState ][j];

					if ( menuBLinkID === menuALinkID ) {
						menuBLinkIDs.splice( j, 1 );
					}
				}

				delete menuLinks[ menuALinkID ];
			}

			delete menuA.links[ checkingState ];
		}

		return menuA;
	}


	function removeMenu ( startingMenu, pathToRemove ) {
		//	We allow a name or a path to be passed.
		//	So I have to find the item that needs to be removed
		//		then take its parent, to find where to remove it
		var menuToRemove		=	getMenu( startingMenu, pathToRemove );
		var parentMenu;
		var removedMenuIndex;

		if ( menuToRemove ) {
			parentMenu			=	menuToRemove.parent;
			removedMenuIndex	=	parentMenu.nav.indexOf( menuToRemove );

			//	If the item exists, remove it
			if ( removedMenuIndex >= 0 ) {
				//	Unlinking the menu removes some hanging objects,
				//		preventing some memory leaks... I hope.
				unlinkMenus( menuToRemove );
				parentMenu.nav.splice( removedMenuIndex, 1 );
			}
		}

		//	Return the original menu to allow chaining
		return startingMenu;

	}


	function getMenu ( startingMenu, path ) {

		var pathSegments	=	ng.isArray( path ) ?
				path :
				path.split('/') || [];
		var pathSegment;
		var i, j;
		var menu;
		var menuFound;
		var menuSet	=	startingMenu.nav;

		//	We'll loop through the path segments, checking
		//		that each one exists. Once we reach the last
		//		pathSegment and it exists, we can return the
		//		menu with that name.
		//	If any one doesn't exist, we return undefined instead
		for ( i = 0; i < pathSegments.length; i+=1 ) {
			j			=	0;
			pathSegment	=	pathSegments[i];
			menuFound	=	false;

			for ( j = 0; j < menuSet.length; j+=1 ) {
				menu = menuSet[j];

				if ( pathSegment === menu.name ) {
					menuSet		=	menu.nav;
					menuFound	=	true;

					break;
				}
			}

			if ( !menuFound ) {
				//	Return undefined if the menu isn't found
				//	TODO: I want a better way of handling this?
				return undefined;
				//	Maybe:
				//	return emptyMenu;
			}
		}


		//	Return the found menu
		return menu;

	}

	function getSetStates ( state, nav ) {
		var i = 0;
		var str = '';
		var strLength;
		var n = nav || brkMenu.nav;
		var item;

		for (; i<n.length; i+=1 ) {
			item = n[i];
			str += item.is[ state ] ? item.path + '//' : '';

			if ( item.nav.length > 0 ) {
				str += getSetStates( state, item.nav );
			}
		}

		return str;
	}

	function getStates ( state, nav ) {
		var str = getSetStates( state, nav );

		return str.substr( 0, str.length-2 );
	}

	function setInitialMenuStates ( state, menus ) {
		var menuPath;
		var initialState;
		var initialStatesSet;

		for ( menuPath in menus ) {
			initialState = menus[ menuPath ];

			initialStates[ menuPath ] = initialStates[ menuPath ] || {};
			initialStates[ menuPath ][ state ] = initialState;
		}

		return brkMenu;
	}





	var brkMenu		=	{};
	var menus		=	[];
	var settings	=	{
		maxLinkIterations:	3
	};
	var menuLinks		=	{};
	var initialStates	=	{};
	//	Could possibly be a better option than returning
	//		undefined in some places? The name can be checked,
	//		but it may help prevent some errors.
	//var emptyMenu	=	new Menu({ name: '[EMPTY]' });





	brkMenu.nav		=	menus;

	//	Mocking brkMenu to be a demi-menu itself
	brkMenu.add		=	addMenu.bind( undefined, brkMenu );
	brkMenu.remove	=	removeMenu.bind( undefined, brkMenu );
	brkMenu.get		=	getMenu.bind( undefined, brkMenu );

	//	Internal functions
	brkMenu.linkMenus	=	linkMenus;
	brkMenu.addMenu		=	addMenu;
	brkMenu.removeMenu	=	removeMenu;
	brkMenu.getMenu		=	getMenu;

	brkMenu.getStates	=	getStates;
	brkMenu.setInitial	=	setInitialMenuStates;





	return brkMenu;

	//	Depends on:
	//	 -	brkID
}]);



})( document, window, angular );
(function( document, window, ng, undefined ){'use strict';



/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */
/*  SHA-256 implementation in JavaScript                (c) Chris Veness 2002-2014 / MIT Licence  */
/*                                                                                                */
/*  - see https://www.movable-type.co.uk/scripts/sha256.html
/*
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */
/*	Many comments removed and code simplified for brevity
/*	Please see the URL above for original code
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */

function ROTR (n, x) {
	return (x >>> n) | (x << (32-n));
};

function Σ0 (x) { return ROTR(2,  x) ^ ROTR(13, x) ^ ROTR(22, x); };
function Σ1 (x) { return ROTR(6,  x) ^ ROTR(11, x) ^ ROTR(25, x); };
function σ0 (x) { return ROTR(7,  x) ^ ROTR(18, x) ^ (x>>>3);  };
function σ1 (x) { return ROTR(17, x) ^ ROTR(19, x) ^ (x>>>10); };
function Ch (x, y, z) { return (x & y) ^ (~x & z); };
function Maj (x, y, z) { return (x & y) ^ (x & z) ^ (y & z); };

function toHexStr (n) {
	var s="", v;
	for (var i=7; i>=0; i--) { v = (n>>>(i*4)) & 0xf; s += v.toString(16); }
	return s;
};

function utf8Encode ( str ) {
	return unescape( encodeURIComponent( str ) );
};

/*	I don't think this is used?
function utf8Decode ( str ) {
	try {
		return decodeURIComponent( escape( str ) );
	} catch (e) {
		return str;
	}
};
*/



ng.module('brk')

.filter( 'brkSha256', [function () {

	return function hash ( msg ) {
		msg = utf8Encode( msg );

		var K = [
			0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
			0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
			0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
			0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
			0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
			0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
			0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
			0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2 ];

		var H = [
			0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19 ];

		msg += String.fromCharCode(0x80);

		var l = msg.length/4 + 2;
		var N = Math.ceil(l/16);
		var M = new Array(N);

		for (var i=0; i<N; i++) {
			M[i] = new Array(16);
			for (var j=0; j<16; j++) {
				M[i][j] = (msg.charCodeAt(i*64+j*4)<<24) | (msg.charCodeAt(i*64+j*4+1)<<16) |
						  (msg.charCodeAt(i*64+j*4+2)<<8) | (msg.charCodeAt(i*64+j*4+3));
			}
		}

		M[N-1][14] = ((msg.length-1)*8) / Math.pow(2, 32); M[N-1][14] = Math.floor(M[N-1][14]);
		M[N-1][15] = ((msg.length-1)*8) & 0xffffffff;

		var W = new Array(64); var a, b, c, d, e, f, g, h;
		for (var i=0; i<N; i++) {

			for (var t=0;  t<16; t++) W[t] = M[i][t];
			for (var t=16; t<64; t++) W[t] = (σ1(W[t-2]) + W[t-7] + σ0(W[t-15]) + W[t-16]) & 0xffffffff;

			a = H[0]; b = H[1]; c = H[2]; d = H[3]; e = H[4]; f = H[5]; g = H[6]; h = H[7];

			for (var t=0; t<64; t++) {
				var T1 = h + Σ1(e) + Ch(e, f, g) + K[t] + W[t];
				var T2 =     Σ0(a) + Maj(a, b, c);
				h = g;
				g = f;
				f = e;
				e = (d + T1) & 0xffffffff;
				d = c;
				c = b;
				b = a;
				a = (T1 + T2) & 0xffffffff;
			}

			H[0] = (H[0]+a) & 0xffffffff;
			H[1] = (H[1]+b) & 0xffffffff;
			H[2] = (H[2]+c) & 0xffffffff;
			H[3] = (H[3]+d) & 0xffffffff;
			H[4] = (H[4]+e) & 0xffffffff;
			H[5] = (H[5]+f) & 0xffffffff;
			H[6] = (H[6]+g) & 0xffffffff;
			H[7] = (H[7]+h) & 0xffffffff;
		}

		return toHexStr(H[0]) + toHexStr(H[1]) + toHexStr(H[2]) + toHexStr(H[3]) +
			   toHexStr(H[4]) + toHexStr(H[5]) + toHexStr(H[6]) + toHexStr(H[7]);
	};
}]);



})( document, window, angular );
