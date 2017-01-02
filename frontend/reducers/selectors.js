export const allTodos = state => {
  return Object.keys(state.todos).map(index => (
    state.todos[index]
  ));
};
