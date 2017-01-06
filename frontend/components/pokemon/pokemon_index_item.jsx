import React from 'react';
import { Link } from 'react-router';

const PokemonIndexItem = ({pokemon}) => (
  <li>
    <Link to={`pokemon/${pokemon.id}`}>
      <span className='col-1-3'>{ pokemon.id }</span>
      <img className='col-1-3' src={ pokemon.image_url } className='pokemon-list-image' />
      <span className='col-1-3'>{ pokemon.name }</span>
    </Link>
  </li>
);

export default PokemonIndexItem;
