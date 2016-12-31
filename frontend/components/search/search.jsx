import React from 'react';
import BenchMap from '../bench_map/bench_map';
import BenchIndex from '../benches/bench_index';

const Search = (props) => (
  <div>
    <BenchMap />
    <BenchIndex fetchBenches={props.fetchBenches} benches={props.benches}/>
  </div>
);

export default Search;
