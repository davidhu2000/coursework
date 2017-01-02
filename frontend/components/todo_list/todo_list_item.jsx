import React from 'react';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.todo = this.props.todo;
    this.handleDelete = this.handleDelete.bind(this);
  }

  handleDelete(e) {
    e.preventDefault();
    this.props.removeTodo(this.todo);
  }

  render() {
    return (
      <li key={this.todo.id}>{this.todo.title}
        <button type="button" onClick={this.handleDelete}>Delete</button>
      </li>
    );
  }
}

export default TodoListItem;
