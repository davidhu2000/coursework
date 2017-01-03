export const getTodos = () => (
  $.ajax({
    method: 'GET',
    url: 'api/todos'
  })
);
