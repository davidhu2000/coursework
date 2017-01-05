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
          <span className='pokemon-detail-name'>{details.name}</span>
          <span className='pokemon-detail-poke-type'>{details.poke_type}</span>
          <span className='pokemon-detail-attack'>{details.attack}</span>
          <span className='pokemon-detail-defense'>{details.defense}</span>
          <ul>
            { details.moves.map( (move, idx) => <li key={idx}>{move}</li> )}
          </ul>
          <ul>
            { details.items.map( (item, idx) => this.renderItemImage(item, idx) )}
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
