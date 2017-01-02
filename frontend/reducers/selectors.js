export const allTodos = ({ todos }) => {
  return Object.keys(todos).map(index => (
    todos[index]
  ));
};
