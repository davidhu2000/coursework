import { RECEIVE_BENCHES } from '../actions/bench_actions';

const BenchReducer = (state = {}, action) => {
  Object.freeze(state);
  // console.log('BenchReducer');
  // console.log(state);
  // console.log(action);
  switch(action.type) {
    case RECEIVE_BENCHES:
      console.log(action.benches);
      return action.benches;
    default:
      return state;
  }
};

export default BenchReducer;
