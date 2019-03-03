(function(){"use strict";



angular.module( 'map' ).factory( 'districtsService', districtsService );
districtsService.$inject = [ 'googlemaps', 'value_districts' ];


function districtsService ( googlemaps, value_districts ) {
	var districtsService = {};

	var districts = [];
	var activePlaces = [];
	var map;
	var placesService;
	var districtName;
	var drawingManager;



	//	RETURN
	districtsService.init      = initialize;
	districtsService.show      = showDistrict;
	districtsService.hide      = hideDistrict;
	districtsService.toggle    = toggleDistrict;
	districtsService.list      = districts;

	return districtsService;



	//	FUNCTIONS
	function initialize( containerElt ) {
		map = new googlemaps.Map( containerElt, {
			zoom: 11,
			center: { lat: 1.317232, lng: 103.840649 },
		});
		placesService = new google.maps.places.PlacesService(map);

		addDistricts();
	}

	function addDistricts () {
		for ( districtName in value_districts ) {
			addDistrict( value_districts[ districtName ][0], districtName );
		}
	}

	function addDistrict ( districtData, districtName ) {
		var districtPoints = districtData.points;
		var districtCoords = [];
		var districtCenter = getDistrictCenter( districtData );
		var districtRadius = getDistrictRadius( districtData, districtCenter );
		var district;
		var point;
		var districtPolygon;
		var i;

		for ( i = 0; i < districtPoints.length; ++i ) {
			point = districtPoints[i];

			districtCoords.push(
				new google.maps.LatLng( point.k, point.D )
			);
		}

		districtPolygon = new google.maps.Polygon({
			paths: districtCoords,
			strokeColor: '#303F9F',
			strokeOpacity: 0.5,
			strokeWeight: 1,
			fillColor: '#303F9F',
			fillOpacity: 0.25
		});

		district = {
			polygon:  districtPolygon,
			data:     districtData,
			isActive: false,
			center:   districtCenter,
			radius:   districtRadius,
			places:	  []
		};

		findPlacesInDistrict ( district );

		districts.push( district );

	}

	function showDistrict ( districtPolygonID ) {
		if (    typeof districtPolygonID === 'number'
		     && !districts[ districtPolygonID ].isActive ) {

			districts[ districtPolygonID ].polygon.setMap( map );
			districts[ districtPolygonID ].isActive = true;
		}
	}

	function hideDistrict ( districtPolygonID ) {
		if (    typeof districtPolygonID === 'number'
		     && districts[ districtPolygonID ].isActive ) {

			districts[ districtPolygonID ].polygon.setMap( null );
			districts[ districtPolygonID ].isActive = false;
		}
	}

	function toggleDistrict ( districtPolygonID ) {
		if ( typeof districtPolygonID === 'number' ) {
			if ( districts[ districtPolygonID ].isActive ) {
				hideDistrict ( districtPolygonID );
			} else {
				showDistrict ( districtPolygonID );
			}
		}
	}

	function getDistrictCenter ( districtData ) {
		var districtPoints = districtData.points;
		var DMax = -9e9;
		var DMin = 9e9;
		var kMin = 9e9;
		var mMax = -9e9;
		var center;
		var point;
		var i;

		for ( i=0; i<districtPoints.length; i+=1 ) {
			point = districtPoints[i];

			DMax = Math.max( DMax, point.k );
			DMin = Math.min( DMin, point.k );
			kMin = Math.min( kMin, point.D );
			mMax = Math.max( mMax, point.D );
		}

		return {
			k: ( DMax + DMin ) / 2,
			D: ( kMin + mMax ) / 2
		};
	}

	function getDistrictRadius ( districtData, districtCenter ) {
		var districtPoints = districtData.points;
		var maxDistance = 0;
		var vector;
		var i;

		for ( i=0; i<districtPoints.length; i+=1 ) {
			vector = {
				k: districtCenter.k - districtPoints[i].k,
				D: districtCenter.D - districtPoints[i].D
			};

			maxDistance = Math.max(
				maxDistance,
				Math.pow( Math.pow( vector.k, 2 ) + Math.pow( vector.D, 2 ), 1/2 )
			);
		}

		return maxDistance;
	}

	function findPlacesInDistrict ( district ) {

		var request = {
			location: new google.maps.LatLng( district.center.k, district.center.D ),
			radius: '' + district.radius * 100000,
			types: ['food']
		};

		placesService.nearbySearch(request, callback);



		function callback(results, status) {
			if (status == google.maps.places.PlacesServiceStatus.OK) {
				for (var i = 0; i < results.length; i++) {
					var place = results[i];

					if ( google.maps.geometry.poly.containsLocation(new google.maps.LatLng( place.geometry.location.G, place.geometry.location.K ), district.polygon ) ) {
						district.places.push( place );
						//createMarkerYellow(results[i]);
					}
				}
			}
		}
	}
}


}());