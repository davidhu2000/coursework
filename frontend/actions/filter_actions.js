import { fetchBenches } from './bench_actions';

export const UPDATE_BOUNDS = 'UPDATE_BOUNDS';

export const updateBounds = bounds => ({
  type: UPDATE_BOUNDS,
  bounds
});

export const updateFilter = filter => dispatch => {
  console.log('updateFilter');
  console.log(filter);
  dispatch(updateBounds(filter));
  return fetchBenches(filter)(dispatch);
};

window.updateFilter = updateFilter;
