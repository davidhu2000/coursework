import React from 'react';
import { selectAllPokemon } from '../../reducers/selectors';

class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render() {
    console.log('rendering');
    console.log(this.props.pokemon);
    console.log(selectAllPokemon);
    console.log(selectAllPokemon(this.props.pokemon));
    if(this.props.pokemon) {
      return (
        <ul>
          {
            selectAllPokemon(this.props.pokemon).map( (pokemon, idx) => (
              <li key={idx}>
                <span>{ pokemon.name }</span>
                <img src={ pokemon.image_url } width="50px" />
              </li>
            ))
          }
        </ul>
      );
    } else {
      return (<div></div>);
    }
  }
}

export default PokemonIndex;
