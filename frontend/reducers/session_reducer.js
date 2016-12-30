import { merge } from 'lodash';

import { RECEIVE_CURRENT_USER,
         RECEIVE_ERRORS,
       } from '../actions/session_actions';

const _defaultState = {
  currentUser: null,
  errors: []
};

const SessionReducer = (state = _defaultState, action) => {
  Object.freeze(state);
  console.log('SessionReducer');
  console.log(state);
  console.log(action);
  switch (action.type) {
    case RECEIVE_CURRENT_USER:
      return {
        currentUser: action.currentUser,
        errors: []
      };
    case RECEIVE_ERRORS:
      return merge({}, _defaultState, { errors: action.errors } );
    default:
      return state;
  }
};

export default SessionReducer;
