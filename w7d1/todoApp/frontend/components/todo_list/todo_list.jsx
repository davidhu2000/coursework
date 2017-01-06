import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

class TodoList extends React.Component {
  constructor(props) {
    super(props);
    this.renderErrors = this.renderErrors.bind(this);
    this.creating = true;
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
          <ul className='error-list'>
            {
              this.props.errors.map( (error, id) => (
                <li className='error' key={id}>{error}</li>
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
        <ul className='todo-list'>
          {
            this.props.todos.map( (todo, id) => (
              <TodoListItem key={id}
                            todo={todo}
                            updateTodo={this.props.updateTodo}
                            deleteTodo={this.props.deleteTodo} />
            ))
          }
        </ul>
        <TodoForm createTodo={ this.props.createTodo }
                  creating={ this.creating } />
      </div>
    );
  }
}

export default TodoList;
