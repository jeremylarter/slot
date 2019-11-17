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
          left: 1,
          center: 1,
          right: 1
        }} />
      </header>
    </div>
  );
}

export default App;
