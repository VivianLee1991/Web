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
      isLock: 0,
      isWin: 0,
      score: 100,
    };

    this.channel.join()
      .receive("ok", this.gotView.bind(this))  // receive the return value of join function
      .receive("error", resp => { console.log("Unable to join", resp) });
  }

  // update the state of class Demo.
  gotView(view) {
    console.log("New view");
    this.setState(view.game)
  }

  guess(index) {
    this.channel.push("guess", {card: index})
        .receive("ok", this.gotView.bind(this));

    if (this.state.isLock == 1) {  // after locking for 1000ms, do the following actions.
      setTimeout(() => {
        console.log("send recover");
        this.channel.push("recover", {card: index})
            .receive("ok", this.gotView.bind(this));
      }, 1000);
    }
  }
 /*
  guess(index) {
    if (this.state.isLock == 1) {

    }
    else {
      this.channel.push("guess", {card: index})
          .receive("ok", this.gotView.bind(this));

      if (this.state.isLock == 1) {  // after locking for 1000ms, do the following actions.
        setTimeout(() => {
          console.log("send recover");
          this.channel.push("recover", {card: index})
              .receive("ok", this.gotView.bind(this));
        }, 1000);
      }
    }
  }
*/
  restart() {
    this.channel.push("restart", {restart: 1})
        .receive("ok", this.gotView.bind(this));
  }

  renderCard(i) {
    return (
      <Card
        value = {this.state.memory[i]}
        onClick = {() => this.guess(i)}/>
    );
  }

  render() {
    let score = "Your Score: " + this.state.score;
    let winNote = '';
    if (this.state.isWin == 1) {
      winNote = "You Win !!!";
    }

    return (
      <div className="gameBoard">
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
        <div className="score">
          <p>{score + " " + winNote}</p>
        </div>
        <div>
          <Button className="restart" onClick={() =>
            this.restart()}>Restart!</Button>
        </div>
        <div>
          <div>{"memory: " + this.state.memory}</div>
          <div>{"isLock: " + this.state.isLock}</div>
          <div>{"isWin: " + this.state.isWin}</div>
          <div>{"score: " + this.state.score}</div>
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
