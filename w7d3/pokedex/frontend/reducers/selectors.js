import { values } from 'lodash';

export const selectAllPokemon = pokemon => (
  values(pokemon)
);

export const selectPokemonItem = (items, itemId) => {
  return items.filter( (item) => item.id === parseInt(itemId) )[0];
};
