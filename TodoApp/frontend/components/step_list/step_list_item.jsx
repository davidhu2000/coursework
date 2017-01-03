import React from 'react';

class StepListItem extends React.Component {
  constructor(props) {
    super(props);
    this.state = props.step;
    this.handleDelete = this.handleDelete.bind(this);
    this.handleDone = this.handleDone.bind(this);
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

    this.props.receiveStep(this.state);
  }

  handleDelete(e) {
    e.preventDefault();
    this.props.removeStep(this.state);
  }

  render() {
    return (
      <li>
        { this.step.title }: { this.step.body }
        <button type="button" onClick={this.handleDone}>{this.state.done === false ? "done" : "undo"}</button>
        <button type="button" onClick={this.handleDelete}>Delete</button>
      </li>
    );
  }
}

export default StepListItem;
