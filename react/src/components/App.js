import React, {Component} from 'react';
import Word from './Word'

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      data: []
    }
    this.getData = this.getData.bind(this);
  }

  getData() {
    $.ajax({
      url: '/words.json',
      contentType: 'application/json'
    })
    .done(data => {
      this.setState({data: data})
    })
  }

  componentWillMount() {
    this.getData()
    let counter = setInterval(this.getData, 10000);
  }

  render () {
    let words = this.state.data.map(word => {
      return (
        <Word
          key={word.id}
          name={word.word}
          id={word.id}
        />
      )
    })
    return (
      <div>
        {words}
      </div>
    )
  }
}


export default App;
