/* global google */

class MarkerManager {
  constructor(map) {
    this.map = map;
    this.markers = [];
  }

  updateMarkers(benches) {
    console.log('time to update');
    let benchesToAdd = this._benchesToAdd(benches);
    benchesToAdd.forEach( bench => {
      this._createMarkerFromBench(bench);
    });
    console.log(this.markers);
  }

  _benchesToAdd(benches) {
    let currentMarkers = this.markers.map( marker => marker.benchId );
    return benches.filter( bench => !currentMarkers.includes(bench.id) );
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

  _markersToRemove() {

  }

  _removeMarker(marker) {

  }
}

export default MarkerManager;
