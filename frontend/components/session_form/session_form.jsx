import React from 'react';
import { merge } from 'lodash';
import { Link, withRouter } from 'react-router';

class SessionForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = { username: '', password: ''};
  }

  componentDidMount() {
    this.redirect();
  }

  handleSubmit(e) {
    e.preventDefault();
    const user = merge({}, this.state);
    this.props.processForm(user).then(() => this.redirect());
  }

  handleUpdate(field) {
    return e => {
      this.setState({
        [field]: e.currentTarget.value
      });
    };
  }

  redirect() {
    if(this.props.loggedIn) this.props.router.push('/');
  }

  renderErrors() {
    return (
      <ul>
        { this.props.errors.map( error => <li>error</li>) }
      </ul>
    );
  }

  render() {
    let type = this.props.formType;
    let linkName = type === 'login' ? 'signup' : 'login';


    return (
      <div>
        { this.renderErrors() }
        <Link to={`\\` + linkName}>{linkName}</Link>
        <h1>{ type }</h1>
        <form onSubmit={this.handleSubmit}>
          <label>
            Username:
            <input type='text'></input>
          </label>
          <label>
            Password:
            <input type='password'></input>
          </label>
        </form>
      </div>
    );
  }
}
