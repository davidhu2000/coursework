import * as ApiUtil from '../util/bench_api_util';

export const RECEIVE_BENCHES = 'RECEIVE_BENCHES';

export const receiveBenches = benches => ({
  type: RECEIVE_BENCHES,
  benches
});

export const fetchBenches = filter => dispatch => {
  return ApiUtil.fetchBenches(filter)
    .then(benchRes => dispatch(receiveBenches(benchRes))
  );
};
