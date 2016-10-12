import React from 'react';

const Word = props => {
  return (
    <div>
      Word: <a href={'/words/'+props.id}>{props.name}</a>
    </div>
  )
}

export default Word;
