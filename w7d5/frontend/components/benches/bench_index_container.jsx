import { connect } from 'react-redux';
import { fetchBenches } from '../../actions/bench_actions';
import BenchIndex from './bench_index';

const mapPropsToState = ({ benches }) => ({
  benches
});

// TODO: maybe remove
const mapDispatchToProps = dispatch => ({
  fetchBenches: () => dispatch(fetchBenches())
});

export default connect(
  mapPropsToState,
  mapDispatchToProps
)(BenchIndex);
