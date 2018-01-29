import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function run_demo(root) {
  ReactDOM.render(<Demo />, root);
}

function Card(props) {
  return (
    <button className="card" onClick={props.onClick}>
      {props.value}
    </button>
  );
}

class Demo extends React.Component {
  const cardValues=['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
  constructor(props) {
    super(props);
    this.state = {
      memory: Array(16).fill(null),
      isGuess: false,
      completeNum: 0,
    };
  }

  handleClick(i) {
    const memory = this.state.memory.slice();
    memory[i] = this.state.cardValues[i];
    this.setState({
      memory: memory,
      isGuess: false,
      completeNum: 0,
    });
  }

  renderCard(i) {
    return (
      <Card
        value={this.state.memory[i]}
        onClick={() => this.handleClick(i)}
      />
    );
  }

  render() {
    return (
      <div>
        <div>
          {this.renderCard(0)}
          {this.renderCard(1)}
          {this.renderCard(2)}
          {this.renderCard(3)}
        </div>
        <div>
          {this.renderCard(4)}
          {this.renderCard(5)}
          {this.renderCard(6)}
          {this.renderCard(7)}
        </div>
        <div>
          {this.renderCard(8)}
          {this.renderCard(9)}
          {this.renderCard(10)}
          {this.renderCard(11)}
        </div>
        <div>
          {this.renderCard(12)}
          {this.renderCard(13)}
          {this.renderCard(14)}
          {this.renderCard(15)}
        </div>
      </div>
    );
  }
}
