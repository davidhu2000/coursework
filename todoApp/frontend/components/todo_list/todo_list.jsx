import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

class TodoList extends React.Component {
  constructor(props) {
    super(props);
    this.renderErrors = this.renderErrors.bind(this);
  }

  componentDidMount() {
    this.props.fetchTodos();
    this.forceUpdate();
  }

  renderErrors() {
    if(this.props.errors.length !== 0) {
      return (
        <div>
          <h3>Errors</h3>
          <ul>
            {
              this.props.errors.map( (error, id) => (
                <li key={id}>{error}</li>
              ))
            }
          </ul>
        </div>
      );
    }
  }

  render() {
    return (
      <div>
        { this.renderErrors() }
        <ul>
          {
            this.props.todos.map( (todo, id) => (
              <TodoListItem key={id}
                            todo={todo}
                            updateTodo={this.props.updateTodo}
                            deleteTodo={this.props.deleteTodo} />
            ))
          }
        </ul>
        <TodoForm createTodo={this.props.createTodo}/>
      </div>
    );
  }
}

export default TodoList;
