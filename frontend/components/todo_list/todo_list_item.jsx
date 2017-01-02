import React from 'react';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.todo = this.props.todo;
  }

  render() {
    return (
      <li key={this.todo.id}>{this.todo.title}</li>
    );
  }
}

export default TodoListItem;
