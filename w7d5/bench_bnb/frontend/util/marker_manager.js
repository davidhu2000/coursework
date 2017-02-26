/* global google */

import { values } from 'lodash';

class MarkerManager {
  constructor(map) {
    this.map = map;
    this.markers = [];
  }

  updateMarkers(benches) {
    this._removeAllMarkers();
    let benchesToAdd = this._benchesToAdd(benches);
    benchesToAdd.forEach( bench => {
      this._createMarkerFromBench(bench);
    });
  }

  _benchesToAdd(benches) {
    let currentMarkers = this.markers.map( marker => marker.benchId ) || [];
    return values(benches).filter( bench => !currentMarkers.includes(bench.id) );
  }

  _createMarkerFromBench(bench) {
    let pos = { lat: bench.lat, lng: bench.lng };

    const marker = new google.maps.Marker({
      position: pos,
      map: this.map,
      benchId: bench.id
    });

    this.markers.push(marker);
  }

  _removeAllMarkers() {
    this.markers.forEach( marker => (marker.setMap(null)) );
    this.markers = [];
  }

  _removeMarker(marker) {
    let markerIdx = this.markers.indexOf(marker);
    delete this.markers[markerIdx];
  }
}

export default MarkerManager;
