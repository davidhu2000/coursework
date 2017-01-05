import React from 'react';
import { selectAllPokemon } from '../../reducers/selectors';
import PokemonIndexItem from './pokemon_index_item';

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
              <PokemonIndexItem key={idx} pokemon={pokemon}/>
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
