(function(){"use strict";



angular.module( 'map' ).directive( "regions", [ regions ]);
regionsController.$inject = [ "$scope", "districtsService" ];



function regions () {
	return {
		restrict: 'E',
		templateUrl: '/templates/regions.html',
		controller: regionsController,
		replace: true
	}
}


function regionsController ( $scope, districtsService ) {

	$scope.ds = districtsService;


}



}());