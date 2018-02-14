import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function run_demo(root, channel) {
  ReactDOM.render(<Demo channel = {channel}/>, root);
}

// App state for Memory is: ??
// {
//    cards:
//    indices:
//    show:
//    isGuess:
//    isLock:
//    lastCard:
//    completeNum:
//    numClicks:
// }

class Demo extends React.Component {
  constructor(props) {
    super(props);
    this.channel = props.channel;
    this.state = {
      memory: [],    // displayed value of each card, "" if hidden.
      isLock: false,
      isWin: false,
      score: 100,
    };

    this.channel.join()
      .receive("ok", this.gotView.bind(this))  // receive the return value of join function
      .receive("error", resp => { console.log("Unable to join", resp) });
  }

  // update the state of class Demo.
  gotView(view) {
    console.log("New view", view);
    this.setState(view.game)
  }

  guess(index) {
    if (this.state.isLock) {
      return;
    }
    else {
      this.channel.push("guess", {card: index})
          .receive("ok", this.gotView.bind(this));
      if (this.state.isLock) {
        setTimeout(() => {  // after locking for 1000ms, do the following actions.
          this.channel.push("recover", {card: index})
              .receive("ok", this.gotView.bind(this));
        }, 1000);
      }
    }
  }

  restart() {
    this.channel.push("restart", {})
        .receive("ok", this.gotView.bind(this));
  }

  renderCard(memoryArray, i) {
    return (
      <Card
        value = {memoryArray[i]}
        onClick = {() => this.guess(i)}
      />
    );
  }

  render() {
    let memoryArray = this.state.memory.toArray();
    let score = "Your Score: " + this.state.score;
    let winNote = '';
    if (this.state.isWin) {
      winNote = "You Win !!!";
    }

    return (
      <div class="gameBoard">
        <div>
          {this.renderCard(memoryArray, 0)}
          {this.renderCard(memoryArray, 1)}
          {this.renderCard(memoryArray, 2)}
          {this.renderCard(memoryArray, 3)}
        </div>
        <div>
          {this.renderCard(memoryArray, 4)}
          {this.renderCard(memoryArray, 5)}
          {this.renderCard(memoryArray, 6)}
          {this.renderCard(memoryArray, 7)}
        </div>
        <div>
          {this.renderCard(memoryArray, 8)}
          {this.renderCard(memoryArray, 9)}
          {this.renderCard(memoryArray, 10)}
          {this.renderCard(memoryArray, 11)}
        </div>
        <div>
          {this.renderCard(memoryArray, 12)}
          {this.renderCard(memoryArray, 13)}
          {this.renderCard(memoryArray, 14)}
          {this.renderCard(memoryArray, 15)}
        </div>
        <div class="score">
          <p>{score + " " + winNote}</p>
        </div>
        <div>
          <Button class="restart" onClick={() =>
            this.restart()}>Restart!</Button>
        </div>
      </div>
    );
  }
}

function Card(props) {
  return (
    <div className="card" onClick={props.onClick}>
      {props.value}
    </div>
  );
}
