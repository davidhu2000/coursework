import * as APIUtil from '../util/api_util';

export const RECEIVE_ALL_POKEMON = "RECEIVE_ALL_POKEMON";
export const RECEIVE_POKEMON = "RECEIVE_POKEMON";
export const RECEIVE_POKEMON_ERRORS = 'RECEIVE_POKEMON_ERRORS';
export const CLEAR_ERRORS = 'CLEAR_ERRORS';

export const receiveAllPokemon = (pokemon) => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
});

export const receivePokemon = pokemon => ({
  type: RECEIVE_POKEMON,
  pokemon
});

export const receivePokemonErrors = errors => ({
  type: RECEIVE_POKEMON_ERRORS,
  errors
});

export const clearErrors = () => ({
  type: CLEAR_ERRORS
});

export const requestAllPokemon = () => dispatch => {
  return APIUtil.fetchAllPokemon()
    .then(pokemon => dispatch(receiveAllPokemon(pokemon)));
};

export const requestSinglePokemon = id => dispatch => {
  return APIUtil.fetchSinglePokemon(id)
    .then(pokemon => dispatch(receivePokemon(pokemon)));
};

export const createPokemon = pokemon => dispatch => {
  return APIUtil.createPokemon(pokemon)
    .then(
      res => {
        dispatch(clearErrors());
        return dispatch(receivePokemon(res));
      },
      error => dispatch(receivePokemonErrors(error.responseJSON))
    );
};
