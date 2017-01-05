import React from 'react';
import { Link } from 'react-router';

const PokemonIndexItem = ({pokemon}) => (
  <li>
    <Link to={`pokemon/${pokemon.id}`}>      
      <span>{ pokemon.name }</span>
      <img src={ pokemon.image_url } width="50px" />
    </Link>
  </li>
);

export default PokemonIndexItem;
