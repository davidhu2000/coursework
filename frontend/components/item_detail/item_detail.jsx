import React from 'react';

const ItemDetail = ({item}) => {
  return <div className="item-detail">
    <span>{item.name}</span>
    <ul className='pokemon-stats'>
      <li>Happiness: {item.happiness}</li>
      <li>Price: ${item.price}</li>
    </ul>
  </div>;
};

export default ItemDetail;
