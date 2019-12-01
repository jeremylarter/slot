import React from 'react';
import './App.css';
import slot from './slot.svg';
import Game from './Game';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={slot} className="App-logo" alt="slot" />
        <p>
          Computing III Slot Machine Simulator
        </p>
        </header>
        <Game />
    </div>
  );
}

export default App;
