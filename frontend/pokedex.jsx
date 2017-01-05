import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';

import * as APIUtil from './util/api_util.js';
import { requestAllPokemon } from './actions/pokemon_actions.js';

document.addEventListener('DOMContentLoaded', ()=> {
  const store = configureStore();
  const root = document.getElementById('root');
  ReactDOM.render(<Root store={store} />, root);

  // window.fetchAllPokemon = APIUtil.fetchAllPokemon;
  // window.requestAllPokemon = requestAllPokemon;
  window.store = store;
});
