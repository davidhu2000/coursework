import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import { allTodos, stepsByTodoId } from './reducers/selectors';
import Root from './components/root';

document.addEventListener("DOMContentLoaded", () => {
  const store = configureStore();
  let root = document.getElementById("root");
  ReactDOM.render(<Root store={store} />, root);

  // for testing
  window.store = store;
  window.allTodos = allTodos;
  window.stepsByTodoId = stepsByTodoId;
});
