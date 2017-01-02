import React from 'react';
import TodoListItem from './todo_list_item';

const TodoList = ({ todos, receiveTodo }) => (
  <ul>
    {
      todos.map( (todo, id) => (
        <TodoListItem key={id} todo={todo}/>
      ))
    }
  </ul>
);

export default TodoList;
