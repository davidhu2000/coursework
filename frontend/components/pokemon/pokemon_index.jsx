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
        <div className='container'>
          <aside className='col col-1-3 scrollable'>
            <ul className='pokemon-list'>
              {
                selectAllPokemon(this.props.pokemon).map( (pokemon, idx) => (
                  <PokemonIndexItem key={idx} pokemon={pokemon}/>
                ))
              }
            </ul>
          </aside>
          <section className='col col-2-3'>
            <div>{this.props.children}</div>
          </section>
        </div>
      );
    } else {
      return (<div></div>);
    }
  }
}

export default PokemonIndex;
