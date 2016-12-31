import { connect } from 'react-redux';
import Search from './search';
import { fetchBenches } from '../../actions/bench_actions';

const mapPropsToState = ({ benches }) => ({
  benches
});

const mapDispatchToProps = dispatch => ({
  fetchBenches: () => dispatch(fetchBenches())
});

export default connect(
  mapPropsToState,
  mapDispatchToProps
)(Search);
