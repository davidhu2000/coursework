import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';

// for testing
import { allTodos, stepsByTodoId } from './reducers/selectors';
import { getTodos } from './util/todo_api_util';

document.addEventListener("DOMContentLoaded", () => {
  const store = configureStore();
  let root = document.getElementById("root");
  ReactDOM.render(<Root store={store} />, root);

  // for testing
  window.store = store;
  window.allTodos = allTodos;
  window.stepsByTodoId = stepsByTodoId;
  window.getTodos = getTodos;
});
