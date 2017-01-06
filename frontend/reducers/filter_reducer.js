import { UPDATE_BOUNDS } from '../actions/filter_actions';

const FilterReducer = (state = {}, action) => {
  Object.freeze(state);
  // console.log('filterReducer');
  // console.log(action);

  switch(action.type) {
    case UPDATE_BOUNDS:
      return action.bounds;
    default:
      return state;
  }
};

export default FilterReducer;
