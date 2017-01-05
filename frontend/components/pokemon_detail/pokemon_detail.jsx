import React from 'react';

class PokemonDetail extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount () {
    this.props.requestSinglePokemon(this.props.params.pokemonId);
  }

  componentWillReceiveProps(newProps) {
    if (this.props.params.pokemonId !== newProps.params.pokemonId) {
      this.props.requestSinglePokemon(newProps.params.pokemonId);
    }
  }

  render() {
    let details = this.props.pokemonDetail;
    console.log(details);
    if(details['name'] !== undefined) {
      return (
        <div className='pokemon-detail'>
          <img src={ details.image_url } className='pokemon-detail-image'/>
          <span className='pokemon-detail-name'>{details.name}</span>
          <span className='pokemon-detail-poke-type'>{details.poke_type}</span>
          <span className='pokemon-detail-attack'>{details.attack}</span>
          <span className='pokemon-detail-defense'>{details.defense}</span>
          <ul>
            { details.moves.map( (move, idx) => <li key={idx}>{move}</li> )}
          </ul>
          <ul>
            { details.items.map( (item, idx) => <li key={idx}>{item.name}</li> )}
          </ul>
        </div>
      );
    } else {
      return (<div></div>)
    }

  }
}

export default PokemonDetail;
