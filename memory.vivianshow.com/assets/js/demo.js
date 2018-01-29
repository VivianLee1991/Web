import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function run_demo(root) {
  ReactDOM.render(<Demo />, root);
}

function initCards() {
  return [
    'A', 'H', 'D', 'E',
    'B', 'C', 'F', 'G',
    'F', 'B', 'G', 'D',
    'C', 'E', 'H', 'A',
  ];
}

function Card(props) {
  return (
    <div className="card" onClick={props.onClick}>
      {props.value}
    </div>
  );
}

class Demo extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      cardValues: initCards(),
      memory: Array(16).fill(' '),
      isGuess: false,
      lastCard: -1,
      completeNum: 0,
      numClicks: 0,
    };
  }

  handleClick(i, isGuess) {
    const memory = this.state.memory.slice();
    if (memory[i] != ' ') {
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
      const numClicks = this.state.numClicks + 1;

      if (memory[i] === memory[lastCard]) {
        const completeNum = this.state.completeNum + 2;
        this.setState({
          memory: memory,
          isGuess: false,
          lastCard: i,
          completeNum: completeNum,
          numClicks: numClicks,
        });
      }
      else {
        this.setState({
          memory: memory,
          isGuess: false,
          lastCard: i,
          numClicks: numClicks,
        });

        setTimeout(() => {
          const completeNum = this.state.completeNum;
          memory[i] = ' ';
          memory[lastCard] = ' ';
          this.setState({
            memory: memory,
            isGuess: false,
            lastCard: i,
            completeNum: completeNum,
          });
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
    let score = "Your Score: " + (100 - this.state.numClicks);
    return (
      <div class="gameBoard">
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
        <div class="score">
          <p>{score}</p>
        </div>
        <div>
          <Button class="restart" onClick={()=>
            this.setState({
              cardValues: initCards(),
              memory: Array(16).fill(' '),
              isGuess: false,
              lastCard: -1,
              completeNum: 0,
              numClicks: 0,
            })}>Restart!</Button>
        </div>
      </div>
    );
  }
}
