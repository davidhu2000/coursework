import { createStore, applyMiddleware } from 'redux';
import rootReducer from '../reducers/root_reducer';
import thunkMiddleware from '../middleware/thunk';
const preloadedState = {};

const configureStore = () => (
  createStore(rootReducer, preloadedState, applyMiddleware(thunkMiddleware))
);

export default configureStore;
