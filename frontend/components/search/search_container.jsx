import { connect } from 'react-redux';
import Search from './search';
import { fetchBenches } from '../../actions/bench_actions';
import { updateBounds } from '../../actions/filter_actions';

const mapPropsToState = ({ benches, filters }) => ({
  benches,
  filters
});

const mapDispatchToProps = dispatch => ({
  fetchBenches: () => dispatch(fetchBenches()),
  updateBounds: bounds => dispatch(updateBounds(bounds))
});

export default connect(
  mapPropsToState,
  mapDispatchToProps
)(Search);
