const _jsxFileName = "/Users/jose/Dropbox/urbit/toe/src/tile/tile.js";import React, { Component } from 'react';
import classnames from 'classnames';
import _ from 'lodash';
import { sigil, reactRenderer } from 'urbit-sigil-js'

const Sigil = props => {
 return (
   React.createElement('div', {__self: this, __source: {fileName: _jsxFileName, lineNumber: 8}}
   , 
     sigil({
       patp: props.patp,
       renderer: reactRenderer,
       size: 30,
       colors: [props.colorF, props.colorB],
     })
   
   )
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
    React.createElement('button', { onClick: props.onClick, style: {width: 40, height: 40}, __self: this, __source: {fileName: _jsxFileName, lineNumber: 31}}
      , React.createElement('p', { style: square, __self: this, __source: {fileName: _jsxFileName, lineNumber: 32}}, props.value)
    )
  );
}

class Board extends React.Component {
  renderSquare(i, j) {
    return (
      React.createElement(Square, {
        value: this.props.squares[i][j],
        onClick: () => this.props.onClick([i, j]), __self: this, __source: {fileName: _jsxFileName, lineNumber: 40}}
      )
    );
  }

  render() {
    const boardRow = {
      display: "flex"
    }
    return (
      React.createElement('div', {__self: this, __source: {fileName: _jsxFileName, lineNumber: 52}}
        , React.createElement('div', { className: "board-row", style: boardRow, __self: this, __source: {fileName: _jsxFileName, lineNumber: 53}}
          , this.renderSquare(0, 0)
          , this.renderSquare(0, 1)
          , this.renderSquare(0, 2)
        )
        , React.createElement('div', { className: "board-row", style: boardRow, __self: this, __source: {fileName: _jsxFileName, lineNumber: 58}}
          , this.renderSquare(1, 0)
          , this.renderSquare(1, 1)
          , this.renderSquare(1, 2)
        )
        , React.createElement('div', { className: "board-row", style: boardRow, __self: this, __source: {fileName: _jsxFileName, lineNumber: 63}}
          , this.renderSquare(2, 0)
          , this.renderSquare(2, 1)
          , this.renderSquare(2, 2)
        )
      )
    );
  }
}

class Message extends React.Component {
  render() {
    return(
      React.createElement('div', { className: "flex absolute" , style: {left: 35, bottom: 15, width: "96%"}, __self: this, __source: {fileName: _jsxFileName, lineNumber: 76}}
        , React.createElement('p', {
          className: "label small dib yellow"   ,
          style: {left: 8}, __self: this, __source: {fileName: _jsxFileName, lineNumber: 77}}
          , this.props.mssg)
      )
  )}
}

class Replay extends React.Component {
  replay(e) {
    e.preventDefault();
    this.props.replay();
  }

  restart(e) {
    e.preventDefault();
    this.props.restart();
  }

  render() {
    return (
      React.createElement('div', { className: "flex absolute" , style: {left: 10, bottom: 1, width: "86%"}, __self: this, __source: {fileName: _jsxFileName, lineNumber: 98}}
        , React.createElement('div', { className: "fl w-20 pa2"  , __self: this, __source: {fileName: _jsxFileName, lineNumber: 99}}
          , this.props.result
        )
        , React.createElement('div', { className: "fl w-20 pa2"  , __self: this, __source: {fileName: _jsxFileName, lineNumber: 102}}
          , React.createElement('p', { className: "small f7 lh-copy yellow"   , __self: this, __source: {fileName: _jsxFileName, lineNumber: 103}}, "play again?" )
        )
        , React.createElement('div', { className: "fl w-60 pa2"  , __self: this, __source: {fileName: _jsxFileName, lineNumber: 105}}
          , React.createElement('button', { className: "fr f6 no-underline br-pill ba ph3 b--white pv2 mb2 fade dim black"           ,
          onClick: this.replay.bind(this), __self: this, __source: {fileName: _jsxFileName, lineNumber: 106}}, "Y"

          )
          , React.createElement('button', { className: "fr f6 no-underline br-pill ba ph3 b--white pv2 mb2 fade dim black"           ,
            onClick: this.restart.bind(this), __self: this, __source: {fileName: _jsxFileName, lineNumber: 110}}, "N"

          )
        )
       )
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
      React.createElement('div', { className: "flex absolute" , style: {left: 10, bottom: 5, width: "86%"}, __self: this, __source: {fileName: _jsxFileName, lineNumber: 133}}
         , React.createElement('p', { className: "label small zdib yellow"   , __self: this, __source: {fileName: _jsxFileName, lineNumber: 134}}, "play with "
              , this.props.mssg, "?"
        )
         , React.createElement('button', { className: "f6 no-underline br-pill ba ph3 b--white pv2 mb2 fade dim black"          ,
            onClick: this.confirmGame.bind(this), __self: this, __source: {fileName: _jsxFileName, lineNumber: 137}}, "Y"

         )
         , React.createElement('button', { className: "f6 no-underline br-pill ba ph3 b--white pv2 mb2 fade dim black"          ,
            onClick: this.rejectGame.bind(this), __self: this, __source: {fileName: _jsxFileName, lineNumber: 141}}, "N"

         )
       )
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
      React.createElement('form', { className: "flex absolute" , style: {left: 30, bottom: 0}, __self: this, __source: {fileName: _jsxFileName, lineNumber: 161}}
        , React.createElement('input', { id: "opponent",
          className: "white pa1 bg-transparent outline-0 bn bb-ns b--white"      ,
          style: {width: "86%"},
          type: "text",
          placeholder: "enter @p (e.g. ~zod)"   ,
          onKeyDown: this.keyPress.bind(this), __self: this, __source: {fileName: _jsxFileName, lineNumber: 162}}
        )
      )
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

  replay() {
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
    console.log(spot, this.state.amNext);
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
      React.createElement('div', { className: "pa2 relative" , style: {
        width: 234,
        height: 234,
        background: '#1a1a1a'
      }, __self: this, __source: {fileName: _jsxFileName, lineNumber: 240}}
        , child
      )
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
        console.log(data);
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
            if (data.status === "replay") {
              game = "replay";
              // Game has ended, so we make both players unable to click on the board
              amNext = false;
              if ('move' in data) {
                squares[data.move[0] - 1][data.move[1] - 1] = data.stone;
              }
              if ('winner' in data) {
                winner = data.winner.replace('~', '');
                if (winner === ship) {
                  result = React.createElement('p', { className: "small f7 lh-copy green"   , __self: this, __source: {fileName: _jsxFileName, lineNumber: 318}}, "You win!" );
                } else if (winner === "tie") {
                  result = React.createElement('p', {
                    style: {fontSize: 8},
                    className: "small f7 lh-copy blue"   , __self: this, __source: {fileName: _jsxFileName, lineNumber: 320}}
                    , React.createElement('a', { target: "_blank",
                    href: (data.stone === stone) ?
                    "https://youtu.be/X8Q9a55zVy4" :
                    "https://youtu.be/itl125pavOM", __self: this, __source: {fileName: _jsxFileName, lineNumber: 323}}, "Stalemate"
                    )
                  );
                 }
                else{
                  result = React.createElement('p', { className: "small f7 lh-copy red"   , __self: this, __source: {fileName: _jsxFileName, lineNumber: 331}}, "You lose" );
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
      React.createElement('div', {__self: this, __source: {fileName: _jsxFileName, lineNumber: 374}}
        , React.createElement('p', { className: "gray label-regular b absolute"   ,
          style: {left: 8, top: 4}, __self: this, __source: {fileName: _jsxFileName, lineNumber: 375}}, "Tic-Tac-Toe"

        )
          , error ? React.createElement(Message, { mssg: message, __self: this, __source: {fileName: _jsxFileName, lineNumber: 379}} ) : null 
          , React.createElement('div', { className: "w-100 h-100 absolute"  , style: {left: 30, top: 73}, __self: this, __source: {fileName: _jsxFileName, lineNumber: 380}}
            , React.createElement(Sigil, { patp: ship, colorF: "white", colorB: "black", __self: this, __source: {fileName: _jsxFileName, lineNumber: 381}} )
             ,  ((game !== 'start') && (game !== 'play')) ?
                React.createElement('p', { className: "tc label-regular b gray"   ,
                style: {left: 27, width: 30}, __self: this, __source: {fileName: _jsxFileName, lineNumber: 383}}, "vs"

                ) : null
              
             ,  ((game === 'play') || (game === 'start')) ?
                React.createElement('p', {
                  className: 
                    classnames("tc", "label-regular", "b",
                    {"red": !amNext, "green": amNext}),
                  style: {left: 27, width: 30}, __self: this, __source: {fileName: _jsxFileName, lineNumber: 389}}
                    ,  amNext ? '↑' : '↓' 
                ) : null
             
             ,  (game !== null) ?
               React.createElement(Sigil, { patp: opponent, colorF: "white", colorB: "black", __self: this, __source: {fileName: _jsxFileName, lineNumber: 398}} ) :
               React.createElement('p', { className: "tc label-regular b blue"   ,
                  style: {width: 30, fontSize: 20}, __self: this, __source: {fileName: _jsxFileName, lineNumber: 399}}, "?"

               )
             
          )
          , React.createElement('div', { className: "w-100 h-100 absolute"  , style: {left: 90, top: 55}, __self: this, __source: {fileName: _jsxFileName, lineNumber: 405}}
            , React.createElement(Board, {
              squares: this.state.squares,
              onClick: spot => this.handleClick(spot), __self: this, __source: {fileName: _jsxFileName, lineNumber: 406}}
            )
          )
          ,  (game === null) ?
            React.createElement(ChooseOpponent, { send: this.sendOpponent.bind(this), __self: this, __source: {fileName: _jsxFileName, lineNumber: 412}} ) : null 
          ,  (game === 'select-opponent') ?
            React.createElement(Message, { mssg: "...waiting for ".concat(opponent), __self: this, __source: {fileName: _jsxFileName, lineNumber: 414}} ) : null 
          ,  (game === 'confirm') ?
            React.createElement(Confirmation, { mssg: opponent, status: status,
              confirm: this.confirmGame.bind(this),
              reject: this.rejectGame.bind(this), __self: this, __source: {fileName: _jsxFileName, lineNumber: 416}} ) : null 
          ,  (game === 'start') ?
            React.createElement(Message, { mssg: "The game begins!", __self: this, __source: {fileName: _jsxFileName, lineNumber: 420}} ) : null 
          ,  (game === 'replay') ?
            React.createElement(Replay, { result: result,
            replay: this.replay.bind(this),
            restart: this.restart.bind(this), __self: this, __source: {fileName: _jsxFileName, lineNumber: 422}} ) : null 
        )
    ));
  }
}

window.toeTile = toeTile;
