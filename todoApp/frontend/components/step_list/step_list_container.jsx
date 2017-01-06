import { connect } from 'react-redux';
import { receiveStep } from '../../actions/step_actions';
import StepList from './step_list';
import { stepsByTodoId } from '../../reducers/selectors';

const mapStateToProps = ({steps}, todoId) => ({
  steps: stepsByTodoId({steps}, todoId),
  todoId
});

const mapDispatchToProps = dispatch => ({
  receiveStep: step => (dispatch(receiveStep(step)))
});

export default connect(mapStateToProps, mapDispatchToProps)(StepList);
