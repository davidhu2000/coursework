import React from 'react';
import StepListContainer from '../step_list/step_list_container';

class TodoDetailView extends React.Component {
  constructor(props) {
    super(props);
    this.body = props.body;
  }

  render() {
    return (
      <ul className="todo-detail">
        <li>{ this.body }</li>
        <ul>
          <StepListContainer />
        </ul>
      </ul>
    );
  }
}

export default TodoDetailView;
