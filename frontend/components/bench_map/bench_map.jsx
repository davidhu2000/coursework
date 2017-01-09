/* global google */

import React from 'react';
import MarkerManager from '../../util/marker_manager';

class BenchMap extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    console.log('Map mounted');
    this.props.fetchBenches();
    const mapOptions = {
      center: { lat: 37.7758, lng: -122.435 },
      zoom: 13
    };
    this.map = new google.maps.Map(this.mapNode, mapOptions);
    this.MarkerManager = new MarkerManager(this.map);

    let updateFilter = this.props.updateFilter;
    let fetchBenches = this.props.fetchBenches;

    this.map.addListener('idle', () => {
      let LatLngBounds = this.map.getBounds();
      let neBound = LatLngBounds.getNorthEast();
      let swBound = LatLngBounds.getSouthWest();

      let bounds = {
        bounds: {
          "northEast": {
            "lat": neBound.lat(),
            "lng": neBound.lng()
          },
          "southWest": {
            "lat": swBound.lat(),
            "lng": swBound.lng()
          }
        }
      };

      fetchBenches(bounds);
      // updateFilter(bounds);
    });
  }

  componentDidUpdate() {
    console.log('map updates');
    // this.props.updateFilter(this.props.filters);
    console.log(this.props.benches);
    console.log(this.MarkerManager.markers);
    this.MarkerManager.updateMarkers(this.props.benches);
  }

  render() {
    return (
      <div id='map-container' ref={ map => this.mapNode = map }>
      </div>
    );
  }
}

export default BenchMap;
