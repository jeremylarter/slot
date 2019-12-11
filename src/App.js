import React from 'react';
import './App.css';
import slot from './slot.svg';
import Game from './Game';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={slot} className="App-logo" alt="slot" />
        <h1>
          Slot Machine Simulator
        </h1>
      </header>
      <Game />
    </div>
  );
}

export default App;
