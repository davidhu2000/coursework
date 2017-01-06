import { connect } from 'react-redux';
import { receiveStep, removeStep } from '../../actions/step_actions';
import StepListItem from './step_list_item';

const mapStateToProps = step => ({
  step
});

const mapDispatchToProps = dispatch => ({
  removeStep: step => dispatch(removeStep(step)),
  receiveStep: step => dispatch(receiveStep(step))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(StepListItem);
