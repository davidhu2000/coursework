import React from 'react';

class PokemonDetail extends React.Component {
  constructor(props) {
    super(props);
    this.showItemDetail = this.showItemDetail.bind(this);
  }

  componentDidMount () {
    this.props.requestSinglePokemon(this.props.params.pokemonId);
  }

  componentWillReceiveProps(newProps) {
    if (this.props.params.pokemonId !== newProps.params.pokemonId) {
      this.props.requestSinglePokemon(newProps.params.pokemonId);
    }
  }

  showItemDetail(id) {
    return e => {
      this.props.router.push(`pokemon/${this.props.pokemonDetail.id}/item/${id}`);
    };
  }

  renderItemImage(item, idx) {
    return (
       <li key={idx}>
         <img className="item-image"
              src={item.image_url}
              onClick={this.showItemDetail(item.id)}/>
       </li>
    );
  }

  render() {
    let details = this.props.pokemonDetail;
    if(details['name'] !== undefined) {
      return (
        <div className='pokemon-detail'>
          <img src={ details.image_url } className='pokemon-detail-image'/>
          <ul className="pokemon-stats">
            <li className='pokemon-detail-name'>{details.name}</li>
            <li className='pokemon-detail-poke-type'>Type: {details.poke_type}</li>
            <li className='pokemon-detail-attack'>Attack: {details.attack}</li>
            <li className='pokemon-detail-defense'>Defense: {details.defense}</li>
            <li>
              <ul className='pokemon-detail-move-list'>
                <label>Moves:</label>
                { details.moves.map( (move, idx) => <li className='pokemon-detail-move' key={idx}>{move}</li> )}
              </ul>
          </li>
            <ul className='item-list'>
              { details.items.map( (item, idx) => this.renderItemImage(item, idx) )}
            </ul>
          </ul>

          { this.props.children }
        </div>
      );
    } else {
      return (<div></div>);
    }

  }
}

export default PokemonDetail;
