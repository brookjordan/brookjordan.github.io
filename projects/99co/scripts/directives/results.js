(function(){"use strict";



angular.module( 'map' ).directive( "results", [ results ]);
resultsController.$inject = [ "$scope", "districtsService" ];



function results () {
	return {
		restrict: 'E',
		templateUrl: '/templates/results.html',
		controller: resultsController,
		replace: true
	}
}


function resultsController ( $scope, districtsService ) {

	$scope.ds = districtsService;

}



}());