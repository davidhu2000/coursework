import React from 'react';
import { merge } from 'lodash';
import { Link, withRouter } from 'react-router';

class SessionForm extends React.Component {
  constructor(props) {
    super(props);
    console.log(props);
    this.state = { username: '', password: ''};
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleUpdate = this.handleUpdate.bind(this);
    this.renderErrors = this.renderErrors.bind(this);
    this.redirect = this.redirect.bind(this);
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
        { this.props.errors.map( (error, idx) => <li key={idx}>{error}</li>) }
      </ul>
    );
  }

  render() {
    let type = this.props.formType;
    let linkName = type === 'login' ? 'signup' : 'login';


    return (
      <div>
        { this.renderErrors() }
        <h1>{ type }</h1>
        <form onSubmit={this.handleSubmit}>
          <label>
            Username:
            <input type='text'
                   onChange={this.handleUpdate('username')}></input>
          </label>
          <label>
            Password:
            <input type='password'
                   onChange={this.handleUpdate('password')}></input>
          </label>
          <input type='submit' value='submit'></input>
        </form>
      </div>
    );
  }
}

export default withRouter(SessionForm);
