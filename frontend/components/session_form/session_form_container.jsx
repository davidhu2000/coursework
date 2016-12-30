import { connect } from 'react-redux';
import SessionFrom from './session_form';
import { login, signup } from '../../actions/session_actions';

const mapStateToProps = ({ loggedIn, errors }) => (
  loggedIn,
  errors
);

const mapDispatchToProps = (dispatch, ownProps) => ({
  formType: ownProps.location.pathname.slice(1),
  processForm: (user) => {
    let type = ownProps.location.pathname.slice(1);
    if(type === 'login') {
      dispatch(login(user));
    } else {
      dispatch(signup(user));
    }
  }
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(SessionFrom);
