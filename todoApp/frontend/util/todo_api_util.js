export const getTodos = () => (
  $.ajax({
    method: 'GET',
    url: 'api/todos'
  })
);

export const createTodo = todo => (
  $.ajax({
    method: "POST",
    url: "api/todos",
    data: { todo: todo }
  })
);

export const updateTodo = todo => (
  $.ajax({
    method: 'PATCH',
    url: `api/todos/${todo.id}`,
    data: { todo: todo }
  })
);

export const deleteTodo = todo => (
  $.ajax({
    method: 'DELETE',
    url: `api/todos/${todo.id}`
  })
);
