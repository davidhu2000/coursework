import { combineReducers } from 'redux';
import pokemonReducer from './pokemon_reducer';
import pokemonDetailReducer from './pokemon_detail_reducer';
import errorsReducer from './errors_reducer';

const rootReducer = combineReducers({
  pokemon: pokemonReducer,
  pokemonDetail: pokemonDetailReducer,
  errors: errorsReducer
});

export default rootReducer;
