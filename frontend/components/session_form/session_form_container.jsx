import { connect } from 'react-redux';
import SessionForm from './session_form';
import { login, signup } from '../../actions/session_actions';

const mapStateToProps = ({ session }) => ({
  loggedIn: Boolean(session.currentUser),
  errors: session.errors
});

const mapDispatchToProps = (dispatch, { location }) => {

  let formType = location.pathname.slice(1);
  let dispatchType;
  if (formType === 'login') {
    dispatchType = login;
  } else {
    dispatchType = signup;
  }

  return {
    processForm: user => dispatch(dispatchType(user)),
    formType
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(SessionForm);
