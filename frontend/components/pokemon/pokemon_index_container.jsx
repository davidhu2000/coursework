import React from 'react';
import { connect } from 'react-redux';
import { requestAllPokemon } from '../../actions/pokemon_actions';
import PokemonIndex from './pokemon_index';

const mapStateToProps = ({ pokemon }) => ({
  pokemon
});

const mapDispatchToProps = dispatch => ({
  requestAllPokemon: pokemon => dispatch(requestAllPokemon(pokemon))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(PokemonIndex);
