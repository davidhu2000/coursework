export const allTodos = ({ todos }) => {
  return Object.keys(todos).map(index => (
    todos[index]
  ));
};

export const stepsByTodoId = ({ steps }, todoId) => {
  let todoSteps = [];
  Object.keys(steps).forEach( index => {
    let currStep = steps[index];
    if (currStep.todoId === todoId) {
      todoSteps.push(currStep);
    }
  });
  return todoSteps;
};
