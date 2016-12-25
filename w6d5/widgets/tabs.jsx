import React from 'react';
import ReactDOM from 'react-dom';

class Tabs extends React.Component {
  constructor(){
    super();

    this.state = {tabIdx: 0,
      tabs: [{title: "one", content: "I am the first"},
            {title: "two", content: "Iam the second"},
            {title: "three", content: "I am the last"}
          ]};
  }

  click(idx) {
    // e.preventDefault();

    this.setState({ tabIdx: idx });
  }

  render(){
    return (
      <div>
        <div className="tab-header">
          {this.state.tabs.map((tab, idx) => <span onClick={this.click.bind(this, idx)} key={idx}>{tab.title}</span>)}
        </div>
        <div className="tab-content">
          <span>{this.state.tabs[this.state.tabIdx].content}</span>
        </div>
      </div>
    );
  }
}

export default Tabs;
