export const fetchAllPokemon = () => (
  $.ajax( {
    method: 'GET',
    url: '/api/pokemon'
  })
);

export const fetchSinglePokemon = id => (
  $.ajax( {
    method: 'GET',
    url: `/api/pokemon/${id}`
  })
);

export const createPokemon = poke => (
  $.ajax({
    method: 'POST',
    url: '/api/pokemon',
    data: { pokemon: poke }
  })
);
