import { RECEIVE_ALL_POKEMON, RECEIVE_POKEMON } from '../actions/pokemon_actions';
import merge from 'lodash/merge';

const pokemonReducer = (state = {}, action) => {
  Object.freeze(state);
  // console.log('pokeReducer');
  // console.log(action);
  switch(action.type) {
    case RECEIVE_ALL_POKEMON:
      return action.pokemon;
    case RECEIVE_POKEMON:
      return merge({}, state, { [action.pokemon.id]: action.pokemon });
    default:
      return state;
  }
};

export default pokemonReducer;
