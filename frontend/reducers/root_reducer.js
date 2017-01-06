import { combineReducers } from 'redux';
import SessionReducer from './session_reducer';
import BenchesReducer from './benches_reducer';
import FilterReducer from './filter_reducer';

const rootReducer = combineReducers({
  session: SessionReducer,
  benches: BenchesReducer,
  filters: FilterReducer
});

export default rootReducer;
