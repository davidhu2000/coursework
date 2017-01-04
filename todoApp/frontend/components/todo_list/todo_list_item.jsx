import React from 'react';
import TodoDetailViewContainer from './todo_detail_view_container';
import merge from 'lodash/merge';

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
    let todo = merge({}, this.props.todo);
    todo.done = !this.props.todo.done;
    this.props.updateTodo(todo);
  }

  handleUpdate(e) {
    e.preventDefault();

  }

  handleTitleClick() {
    this.detail = this.detail ? false : true;
    this.forceUpdate();
  }

  showDetail() {
    if (this.detail) {
      return (
        <TodoDetailViewContainer className="todo-detail" body={this.props.todo.body}/>
      );
    }
  }

  render() {
    return (
      <li key={this.props.todo.id} className='todo'>
        <span className='todo-title' onClick={this.handleTitleClick}>{ this.props.todo.title }</span>
        <button className='todo-button' type="button" onClick={this.handleDone}>{this.props.todo.done === false ? "done" : "undo"}</button>
        <button className='todo-button' type="button" onClick={this.handleDelete}>Delete</button>
        <button className='todo-button' type="button" onClick={this.handleUpdate}>Update</button>
        { this.showDetail() }
      </li>
    );
  }
}

export default TodoListItem;
