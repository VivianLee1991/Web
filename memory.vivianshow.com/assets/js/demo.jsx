import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function run_demo(root) {
  ReactDOM.render(<Demo />, root);
}

function initCards() {
  return [
    'A', 'B', 'C', 'D',
    'E', 'F', 'G', 'H',
    'A', 'B', 'C', 'D',
    'E', 'F', 'G', 'H'
  ];
}

function Card(props) {
  return (
    <button className="card" onClick={props.onClick}>
      {props.value}
    </button>
  );
}

class Demo extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      cardValues: initCards(),
      memory: Array(16).fill(null),
      isGuess: false,
      lastCard: -1,
      completeNum: 0,
    };
  }

  handleClick(i, isGuess) {
    const memory = this.state.memory.slice();
    if (memory[i] != null) {
      return;
    }
    
    memory[i] = this.state.cardValues[i];
    if (!isGuess) {
      this.setState({
        memory: memory,
        isGuess: true,
        lastCard: i,
      });
    }
    else {
      const lastCard = this.state.lastCard;

      if (memory[i] === memory[lastCard]) {
        const completeNum = this.state.completeNum + 2;
        this.setState({
          memory: memory,
          isGuess: false,
          lastCard: i,
          completeNum: completeNum,
        });
      }
      else {
        this.setState({
          memory: memory,
          isGuess: false,
          lastCard: i,
        });

        memory[i] = null;
        memory[lastCard] = null;

        setTimeout(() => {
          this.setState({memory: memory,});
        }, 1000);
      }
    }
  }

  renderCard(i) {
    return (
      <Card
        value={this.state.memory[i]}
        onClick={() => this.handleClick(i, this.state.isGuess)}
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
