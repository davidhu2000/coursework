import React from 'react';
import StepListItemContainer from './step_list_item_container';
const StepList = ({steps}, todoId) => (
  <div>
    <ul>
      {
        steps.map( (step, index) => (
          <StepListItemContainer key={index} step={step} />
          )
        )
      }
    </ul>
  </div>
);

export default StepList;
