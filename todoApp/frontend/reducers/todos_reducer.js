import { RECEIVE_TODOS, RECEIVE_TODO, REMOVE_TODO } from '../actions/todo_actions';
import { merge } from 'lodash';

const initialState = {
  1: {
    id: 1,
    title: "wash car not!",
    body: "with soap",
    done: false
  },
  2: {
    id: 2,
    title: "wash dog",
    body: "with shampoo",
    done: true
  },
  // 3: {
  //   id: 3,
  //   title: "wash dog",
  //   body: "with shampoo",
  //   done: true
  // },
};

const todosReducer = (state = initialState, action) => {
  Object.freeze(state);
  switch(action.type) {
    case RECEIVE_TODOS:
      let newState = {};
      action.todos.forEach( todo => {
        newState[todo.id] = todo;
      });
      return newState;
    case RECEIVE_TODO:
      return merge({}, state, {
         [action.todo.id]: action.todo
      });
    case REMOVE_TODO:
      let removeState = merge({}, state);
      delete removeState[action.todo.id];
      return removeState;
    default:
      return state;
  }
};

export default todosReducer;
