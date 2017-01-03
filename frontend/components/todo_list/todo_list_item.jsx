import React from 'react';
import TodoDetailViewContainer from './todo_detail_view_container';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.state = this.props.todo;
    this.handleDelete = this.handleDelete.bind(this);
    this.handleDone = this.handleDone.bind(this);
    this.handleTitleClick = this.handleTitleClick.bind(this);
    this.detail = false;
    this.showDetail = this.showDetail.bind(this);
  }

  handleDelete(e) {
    e.preventDefault();
    this.props.removeTodo(this.state);
  }

  handleDone(e) {
    e.preventDefault();
    if (this.state.done) {
      this.setState({
        done: false
      });
    } else {
      this.setState({
        done: true
      });
    }

    this.props.receiveTodo(this.state);
  }

  handleTitleClick() {
    this.detail = this.detail ? false : true;
    this.forceUpdate();
    console.log(this.detail);
  }

  showDetail() {
    if (this.detail) {
      return (
        <TodoDetailViewContainer body={this.state.body}/>
      );
    } else {
      console.log('nodetail');
    }
  }

  render() {
    return (
      <li key={this.state.id}>
        <span onClick={this.handleTitleClick}>{ this.state.title }</span>
        <button type="button" onClick={this.handleDone}>{this.state.done === false ? "done" : "undo"}</button>
        <button type="button" onClick={this.handleDelete}>Delete</button>
        { this.showDetail() }
      </li>
    );
  }
}

export default TodoListItem;
