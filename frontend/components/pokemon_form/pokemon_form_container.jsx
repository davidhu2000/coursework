import React from 'react';
import { connect } from 'react-redux';
import { createPokemon } from '../../actions/pokemon_actions';
import PokemonForm from './pokemon_form';

const mapDispatchToProps = dispatch => {
  return {
  createPokemon: pokemon => dispatch(createPokemon(pokemon))
};};

export default connect(null,
  mapDispatchToProps
)(PokemonForm);
