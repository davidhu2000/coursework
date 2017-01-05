import React from 'react';
import { withRouter } from 'react-router';

class PokemonForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: '',
      image_url: '',
      poke_type: '',
      attack: '',
      defense: '',
      moves: []
    };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  renderErrors() {
    return <ul>
      { this.props.errors.map((error, idx) => <li key={idx}>{error}</li>)}
    </ul>;
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.createPokemon(this.state).then((res) => this.renderNewPokemonDetail(res.pokemon.id));
  }

  handleChange(attr) {
    return e => {
        this.setState({ [attr]: e.target.value });
    };
  }

  handleMoveChange(idx) {
    return e => {
      let newMoves = Object.assign(this.state.moves);
      newMoves[idx] = e.target.value;
      this.setState( { moves: newMoves});
    };
  }

  renderNewPokemonDetail (id) {
    this.props.router.push(`/pokemon/${id}`);
  }

  render() {
    return (
      <div>
        {this.renderErrors()}
        <form onSubmit={this.handleSubmit} >
          <input type='text'
                 placeholder='Name'
                 onChange={this.handleChange('name')}
                 value={ this.state.name } />

          <input type='text'
                 placeholder='Image URL'
                 onChange={this.handleChange('image_url')}
                 value={ this.state.image_url } />

               <select defaultValue='select' onChange={this.handleChange('poke_type')}>
            <option disabled value='select'>{'--Select Type--'}</option>
            <option value="bug">bug</option>
            <option value="dragon">dragon</option>
            <option value="electric">electric</option>
            <option value="fighting">fighting</option>
            <option value="fire">fire</option>
            <option value="flying">flying</option>
            <option value="ghost">ghost</option>
            <option value="grass">grass</option>
            <option value="ground">ground</option>
            <option value="ice">ice</option>
            <option value="normal">normal</option>
            <option value="poison">poison</option>
            <option value="psychic">psychic</option>
            <option value="rock">rock</option>
            <option value="steel">steel</option>
            <option value="water">water</option>
         </select>

          <input type='text'
                 placeholder='Attack'
                 onChange={this.handleChange('attack')}
                 value={ this.state.attack } />

          <input type='text'
                 placeholder='Defense'
                 onChange={this.handleChange('defense')}
                 value={ this.state.defense } />

          <input type='text'
                 placeholder='Move 1'
                 onChange={this.handleMoveChange(0)}
                 value={ this.state.moves[0] || ""}/>
          <input type='text'
                 placeholder='Move 2'
                 onChange={this.handleMoveChange(1)}
                 value={ this.state.moves[1] || ""}/>
          <input type='text'
                 placeholder='Move 3'
                 onChange={this.handleMoveChange(2)}
                 value={ this.state.moves[2] || ""}/>
          <input type='submit' value='Create Pokemon' />
        </form>
      </div>
    );
  }
}

export default withRouter(PokemonForm);
