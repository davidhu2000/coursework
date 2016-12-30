import React from 'react';
import ReactDOM from 'react-dom';
import { login, logout, signup } from './util/session_api_util';
import configureStore from './store/store';

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');
  const store = configureStore();

  ReactDOM.render(<h1>BenchBnB</h1>, root);

  // for testing
  window.store = store;
  window.signup = signup;
  window.login = login;
  window.logout = logout;
});
