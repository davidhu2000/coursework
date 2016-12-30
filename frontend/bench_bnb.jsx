import React from 'react';
import ReactDOM from 'react-dom';
import { login, logout, signup } from './util/session_api_util';

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');
  ReactDOM.render(<h1>BenchBnB</h1>, root);

  window.signup = signup;
  window.login = login;
  window.logout = logout;
});
