import React from 'react';
import { connect } from 'react-redux';
import Greeting from './greeting';
import { login, logout, signup } from '../../actions/session_actions';

const mapStateToProps = ({ currentUser }) => ({
  currentUser
});

const mapDispatchToProps = dispatch => ({
  logout: dispatch(logout())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Greeting);
