import React from 'react';
import TodoDetailViewContainer from './todo_detail_view_container';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.handleDelete = this.handleDelete.bind(this);
    this.handleDone = this.handleDone.bind(this);
    this.handleTitleClick = this.handleTitleClick.bind(this);
    this.detail = false;
    this.showDetail = this.showDetail.bind(this);
  }

  handleDelete(e) {
    e.preventDefault();
    this.props.deleteTodo(this.props.todo);
  }

  handleDone(e) {
    e.preventDefault();
    if (this.props.todo.done) {
      this.setState({
        done: false
      });
    } else {
      this.setState({
        done: true
      });
    }

    this.props.updateTodo(this.props.todo);
  }

  handleTitleClick() {
    this.detail = this.detail ? false : true;
    this.forceUpdate();
  }

  showDetail() {
    if (this.detail) {
      return (
        <TodoDetailViewContainer body={this.props.todo.body}/>
      );
    }
  }

  render() {
    return (
      <li key={this.props.todo.id}>
        <span onClick={this.handleTitleClick}>{ this.props.todo.title }</span>
        <button type="button" onClick={this.handleDone}>{this.props.todo.done === false ? "done" : "undo"}</button>
        <button type="button" onClick={this.handleDelete}>Delete</button>
        { this.showDetail() }
      </li>
    );
  }
}

export default TodoListItem;
