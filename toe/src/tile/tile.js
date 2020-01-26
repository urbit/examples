import React, { Component } from 'react';
import classnames from 'classnames';
import _ from 'lodash';
import { sigil, reactRenderer } from 'urbit-sigil-js'

const Sigil = props => {
 return (
   <div>
   {
     sigil({
       patp: props.patp,
       renderer: reactRenderer,
       size: 30,
       colors: [props.colorF, props.colorB],
     })
   }
   </div>
 )
}

function Square(props) {
  const square = {
    fontSize: '24px',
    fontWeight: 'bold',
    lineHeight: '34px',
    marginRight: '-1px',
    padding: '0',
    textAlign: 'center',
  }
  return (
    <button onClick={props.onClick} style={{width: 40, height: 40}}>
      <p style={square}>{props.value}</p>
    </button>
  );
}

class Board extends React.Component {
  renderSquare(i, j) {
    return (
      <Square
        value={this.props.squares[i][j]}
        onClick={() => this.props.onClick([i, j])}
      />
    );
  }

  render() {
    const boardRow = {
      display: "flex"
    }
    return (
      <div>
        <div className="board-row" style={boardRow}>
          {this.renderSquare(0, 0)}
          {this.renderSquare(0, 1)}
          {this.renderSquare(0, 2)}
        </div>
        <div className="board-row" style={boardRow}>
          {this.renderSquare(1, 0)}
          {this.renderSquare(1, 1)}
          {this.renderSquare(1, 2)}
        </div>
        <div className="board-row" style={boardRow}>
          {this.renderSquare(2, 0)}
          {this.renderSquare(2, 1)}
          {this.renderSquare(2, 2)}
        </div>
      </div>
    );
  }
}

class Message extends React.Component {
  render() {
    return(
      <div className="flex absolute" style={{left: 35, bottom: 15, width: "96%"}}>
        <p
          className="label small dib yellow"
          style={{left: 8}}>
          {this.props.mssg}</p>
      </div>
  )}
}

class Rematch extends React.Component {
  rematch(e) {
    e.preventDefault();
    this.props.rematch();
  }

  restart(e) {
    e.preventDefault();
    this.props.restart();
  }

  render() {
    return (
      <div className="flex absolute" style={{left: 10, bottom: 1, width: "86%"}}>
        <div className="fl w-20 pa2">
          {this.props.result}
        </div>
        <div className="fl w-20 pa2">
          <p className="small f7 lh-copy yellow">play again?</p>
        </div>
        <div className="fl w-60 pa2">
          <button className="fr f6 no-underline br-pill ba ph3 b--white pv2 mb2 fade dim black"
          onClick={this.rematch.bind(this)}>
          Y
          </button>
          <button className="fr f6 no-underline br-pill ba ph3 b--white pv2 mb2 fade dim black"
            onClick={this.restart.bind(this)}>
            N
          </button>
        </div>
       </div>
    )
  }
}

class Confirmation extends React.Component {
  confirmGame(e) {
    e.preventDefault();
    this.props.confirm();
  }

  rejectGame(e) {
    e.preventDefault();
    this.props.reject();
  }

  render() {
    return (
      <div className="flex absolute" style={{left: 10, bottom: 5, width: "86%"}}>
         <p className="label small zdib yellow">
            play with {this.props.mssg}?
        </p>
         <button className="f6 no-underline br-pill ba ph3 b--white pv2 mb2 fade dim black"
            onClick={this.confirmGame.bind(this)}>
            Y
         </button>
         <button className="f6 no-underline br-pill ba ph3 b--white pv2 mb2 fade dim black"
            onClick={this.rejectGame.bind(this)}>
            N
         </button>
       </div>
    )
  }
}

class ChooseOpponent extends React.Component {

  keyPress(e) {
    if (e.keyCode === 13) {
      e.preventDefault();
      this.props.send(e.target.value);
    }
  }

  render() {
    return(
      <form className="flex absolute" style={{left: 30, bottom: 0}}>
        <input id="opponent"
          className="white pa1 bg-transparent outline-0 bn bb-ns b--white"
          style={{width: "86%"}}
          type="text"
          placeholder="enter @p (e.g. ~zod)"
          onKeyDown={this.keyPress.bind(this)}>
        </input>
      </form>
    )
  }
}

export default class toeTile extends Component {

  constructor(props) {
    super(props);

    let ship = window.ship;
    let api = window.api;
    let store = window.store;

    this.state = {
      opponent: null,
      subscribers: [],
      error: false,
      squares: Array(3).fill(null).map(x => Array(3).fill(null)),
      stepNumber: 0,
      amNext: false,
      winner: null,
      message: "",
      stone: null,
      game: null,
      result: null
    };
  }

  sendOpponent(opponentShip) {
    api.action('toe', 'json', {'data': opponentShip});
  }

  //  FIXME: This can be grouped in two (confirm/accept)
  confirmGame() {
    api.action('toe', 'json', {'data': 'y'});
  }

  rejectGame() {
    api.action('toe', 'json', {'data': 'n'});
  }

  rematch() {
    this.setState({
      squares: Array(3).fill(null).map(x => Array(3).fill(null)),
    });
    api.action('toe', 'json', {'data': 'y'});
  }

  restart() {
    this.setState({
      squares: Array(3).fill(null).map(x => Array(3).fill(null)),
    });
    api.action('toe', 'json', {'data': 'n'});
  }

  handleClick(spot) {
    const squares = this.state.squares.slice();
    if (this.state.amNext &&  squares[spot[0]][spot[1]] === null) {
      squares[spot[0]][spot[1]] = this.state.stone.toLocaleUpperCase();
      api.action('toe', 'json', {'data': [++spot[0], ++spot[1]]});
      this.setState({
        squares: squares,
        amNext: false
      });
    }
  }

  renderWrapper(child) {
    return (
      <div className="pa2 relative" style={{
        width: 234,
        height: 234,
        background: '#1a1a1a'
      }}>
        {child}
      </div>
    );
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    const data = !!this.props.data ? this.props.data : {};
    let squares = this.state.squares.slice();
    let amNext = this.state.amNext;
    let opponent = this.state.opponent;
    let stone = this.state.stone;
    let winner = this.state.winner;
    let result = this.state.result;
    let game = this.state.game;
    if (data === null) {
      // We reset state
      this.setState({
        opponent: null,
        subscribers: [],
        error: false,
        squares: Array(3).fill(null).map(x => Array(3).fill(null)),
        stepNumber: 0,
        amNext: false,
        winner: null,
        message: "",
        stone: null,
        game: null
      });
    }
    // Typical usage (don't forget to compare props):
    else if (snapshot !== null) {
      let message = !!data.data ? data.data : "";
      if (data !== prevProps.data) {
        // We receive a diff from %toe
        if ('status' in data) {
          if (data.status === "error"){
            this.setState({
              error: !data.error,
              message: data.data
            });
          }else {
            if ('next' in data) {
              amNext = (data.next.replace('~', '') === ship);
            }
            if ((data.status === "select-opponent") ||
                (data.status === "confirm") ||
                (data.status === "wait")) {
              opponent = data.message;
              game = data.status;
              squares = Array(3).fill(null).map(x => Array(3).fill(null));
            }
            if (data.status === "start") {
              game = "start";
              stone = data.stone
              squares = Array(3).fill(null).map(x => Array(3).fill(null));
            }
            if (data.status === "play") {
              game = data.status;
              if ('move' in data) {
                squares[data.move[0] - 1][data.move[1] - 1] = data.stone;
              }
            }
            if (data.status === "rematch") {
              game = "rematch";
              // Game has ended, so we make both players unable to click on the board
              amNext = false;
              if ('move' in data) {
                squares[data.move[0] - 1][data.move[1] - 1] = data.stone;
              }
              if ('winner' in data) {
                winner = data.winner.replace('~', '');
                if (winner === ship) {
                  result = <p className="small f7 lh-copy green">You win!</p>;
                } else if (winner === "tie") {
                  const link1 = "https://youtu.be/X8Q9a55zVy4";
                  const link2 = "https://youtu.be/itl125pavOM";
                  result = <p
                    style={{fontSize: 8}}
                    className="small f7 lh-copy blue">
                    <a target="_blank"
                      href={(data.stone === stone) ? link1: link2}>
                      Stalemate
                    </a>
                  </p>;
                 }
                else{
                  result = <p className="small f7 lh-copy red">You lose</p>;
                }
              }
            }
            if (data.status === "null") {
              game = null;
              opponent = null;
              squares = Array(3).fill(null).map(x => Array(3).fill(null));
              amNext = false;
              winner = null;
              message = "";
              stone = null;
            }
            this.setState({
              game: game,
              message: message,
              amNext: amNext,
              opponent: opponent,
              stone: stone,
              winner: winner,
              squares: squares,
              result: result
            });
          }
        }
      }
    }
  }

  render() {
    let data = !!this.props.data ? this.props.data : {};
    let bottomElement;

    const squares = this.state.squares;
    const opponent = this.state.opponent;
    const game = this.state.game;
    const winner = this.state.winner;
    const message = this.state.message;
    const error = this.state.error;
    const result = this.state.result;
    const amNext = this.state.amNext;

    return this.renderWrapper((
      <div>
        <p className="gray label-regular b absolute"
          style={{left: 8, top: 4}}>
          Tic-Tac-Toe
        </p>
          {error ? <Message mssg={message} /> : null }
          <div className="w-100 h-100 absolute" style={{left: 30, top: 73}}>
            <Sigil patp={ship} colorF='white' colorB='black' />
             { ((game !== 'start') && (game !== 'play')) ?
                <p className="tc label-regular b gray"
                style={{left: 27, width: 30}}>
                  vs
                </p> : null
              }
             { ((game === 'play') || (game === 'start')) ?
                <p
                  className={
                    classnames("tc", "label-regular", "b",
                    {"red": !amNext, "green": amNext})}
                  style={{left: 27, width: 30}}>
                    { amNext ? '↑' : '↓' }
                </p> : null
             }
             { (game !== null) ?
               <Sigil patp={opponent} colorF='white' colorB='black' /> :
               <p className="tc label-regular b blue"
                  style={{width: 30, fontSize: 20}}>
                 ?
               </p>
             }
          </div>
          <div className="w-100 h-100 absolute" style={{left: 90, top: 55}}>
            <Board
              squares={this.state.squares}
              onClick={spot => this.handleClick(spot)}
            />
          </div>
          { (game === null) ?
            <ChooseOpponent send={this.sendOpponent.bind(this)} /> : null }
          { (game === 'select-opponent') ?
            <Message mssg={"...waiting for ".concat(opponent)} /> : null }
          { (game === 'confirm') ?
            <Confirmation mssg={opponent} status={status}
              confirm={this.confirmGame.bind(this)}
              reject={this.rejectGame.bind(this)} /> : null }
          { (game === 'start') ?
            <Message mssg={"The game begins!"} /> : null }
          { (game === 'rematch') ?
            <Rematch result={result}
            rematch={this.rematch.bind(this)}
            restart={this.restart.bind(this)} /> : null }
        </div>
    ));
  }
}

window.toeTile = toeTile;
