import React from 'react';
import './App.css';
import slot from './slot.svg';
import RotateWheelSet from './RotateWheelSet'

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={slot} className="App-logo" alt="slot" />
        <p>
          Computing III Slot Machine Simulator
        </p>
        <RotateWheelSet startPosition={{
          left: 0,
          center: 0,
          right: 0
        }} />
      </header>
    </div>
  );
}

export default App;
