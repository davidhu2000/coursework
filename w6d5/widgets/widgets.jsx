import React from 'react';
import ReactDOM from 'react-dom';
import Tabs from './tabs';
import Clock from './clock';

document.addEventListener("DOMContentLoaded", () => {
  const tabs = document.getElementById("tabs");
  ReactDOM.render(<Tabs />, tabs);
  const clock = document.getElementById("clock");
  ReactDOM.render(<Clock />, clock);
});
