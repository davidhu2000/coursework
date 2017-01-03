import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

class TodoList extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.fetchTodos();
    this.forceUpdate();
  }

  render() {
    return (
      <div>
        <ul>
          {
            this.props.todos.map( (todo, id) => (
              <TodoListItem key={id}
                            todo={todo}
                            receiveTodo={this.props.receiveTodo}
                            removeTodo={this.props.removeTodo.bind(null, todo)} />
            ))
          }
        </ul>
        <TodoForm receiveTodo={this.props.receiveTodo}/>
      </div>
    );
  }
}

export default TodoList;
