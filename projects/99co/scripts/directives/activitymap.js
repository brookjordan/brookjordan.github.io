(function(){"use strict";



angular.module( 'map' ).directive( 'activitymap', [ activitymap ]);
activitymapController.$inject = [ 'districtsService' ];



function activitymap () {
	return {
		restrict: 'E',
		templateUrl: '/templates/activitymap.html',
		controller: activitymapController,
		replace: true
	}
}


function activitymapController ( districtsService ) {
	districtsService.init( document.getElementById('map-canvas') );
}



}());