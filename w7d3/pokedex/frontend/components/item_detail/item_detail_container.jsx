import React from 'react';
import ItemDetail from './item_detail';
import {selectPokemonItem} from '../../reducers/selectors.js';
import { connect } from 'react-redux';

const mapStateToProps = ({ pokemonDetail }, ownProps) => ({
  item: selectPokemonItem(pokemonDetail.items, ownProps.params.itemId)
});


export default connect(
  mapStateToProps
)(ItemDetail);
