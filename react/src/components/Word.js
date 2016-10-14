import React from 'react';

const Word = props => {
  return (
    <li><a href={'/words/'+props.id}>{props.name}</a></li>
  )
}

export default Word;
