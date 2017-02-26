import React from 'react';

const benchItem = bench => (
  <tr key={bench.id}>
    <td>{ bench.description }</td>
    <td>{ bench.lat }</td>
    <td>{ bench.lng }</td>
  </tr>
);

const benchTable = benches => (
  <table>
    <thead>
      <tr>
        <th>Description</th>
        <th>Latitude</th>
        <th>Longitude</th>
      </tr>
    </thead>
    <tbody>
      { benches.map( bench => benchItem(bench) ) }
    </tbody>
  </table>
);

class BenchIndex extends React.Component {

  constructor(props) {
    super(props);
  }

  render() {
    let benches = this.props.benches;

    if (benches instanceof Array) {
      return (
        <div>
          { benchTable(benches) }
        </div>
      );
    } else {
      return (
        <div>No bench available!</div>
      );
    }
  }

}

export default BenchIndex;
