import React from 'react';
import './App.css';
import slot from './slot.svg';
import Game from './Game';

function App() {
  return (
    <div className="text-center">
      <img src={slot} alt="slot logo" />
      <header>
        <h4>
          Slot Machine Simulator
        </h4>
      </header>
      <Game />
    </div>
  );
}

export default App;
