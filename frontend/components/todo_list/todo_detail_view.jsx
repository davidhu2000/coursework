import React from 'react';

class TodoDetailView extends React.Component {
  constructor(props) {
    super(props);
    this.body = props.body;
  }

  render() {
    return (
      <ul>
        <li>{ this.body }</li>
      </ul>
    );
  }
}

export default TodoDetailView;
