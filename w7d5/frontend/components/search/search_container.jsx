import { connect } from 'react-redux';
import Search from './search';
import { fetchBenches } from '../../actions/bench_actions';
import { updateFilter } from '../../actions/filter_actions';

const mapPropsToState = ({ benches, filters }) => ({
  benches,
  filters
});

const mapDispatchToProps = dispatch => ({
  fetchBenches: filters => dispatch(fetchBenches(filters)),
  updateFilter: bounds => updateFilter(bounds)
});

export default connect(
  mapPropsToState,
  mapDispatchToProps
)(Search);
