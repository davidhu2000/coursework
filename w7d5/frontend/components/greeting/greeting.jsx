import React from 'react';
import { Link } from 'react-router';

const loggedInMessage = (currentUser, logout) => (
  <div>
    <h3>Welcome {currentUser.username}</h3>
    <button onClick={logout}>Log Out</button>
  </div>
);

const notLoggedInMessage = () => (
  <div>
    <Link to="/signup">Sign Up</Link>
    &nbsp;&nbsp;
    <Link to="/login">Log In</Link>
  </div>
);

const Greeting = ({currentUser, logout}) => {
  if(currentUser) {
    return loggedInMessage(currentUser, logout);
  } else {
    return notLoggedInMessage();
  }
};


export default Greeting;
