/* global google */

import { values } from 'lodash';

class MarkerManager {
  constructor(map) {
    this.map = map;
    this.markers = [];
  }

  updateMarkers(benches) {
    console.log('time to update');
    console.log(this.markers);
    this._removeOutOfBoundMarkers(benches);
    console.log(this.markers);
    let benchesToAdd = this._benchesToAdd(benches);
    benchesToAdd.forEach( bench => {
      this._createMarkerFromBench(bench);
    });
    // let markersToRemove = this._markersToRemove(benches);
    // console.log('markersToRemove');
    // console.log(markersToRemove);
    // markersToRemove.forEach( marker => {
    //   this._removeMarker(marker);
    // });
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

  _removeOutOfBoundMarkers(benches) {
    let deleteIndex = [];
    this.markers.forEach( (marker, idx) => {
      if(Object.keys(benches).indexOf(marker.benchId) === -1) {
        marker.setMap(null);
        deleteIndex.push(idx);
      }
    });

    for(let i = deleteIndex.length -1; i >= 0; i--) {
      this.markers.splice(i, 1);
    }
  }

  _removeMarker(marker) {
    let markerIdx = this.markers.indexOf(marker);
    delete this.markers[markerIdx];
  }
}

export default MarkerManager;
