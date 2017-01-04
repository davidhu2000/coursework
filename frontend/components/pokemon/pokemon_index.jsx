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
