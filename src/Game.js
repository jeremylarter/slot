import React, { useState, useRef } from 'react';
import RotateWheelSet from './RotateWheelSet'
import DisplayCredit from './DisplayCredit';
import DisplayWin from './DisplayWin';
import DisplayPayouts from './DisplayPayouts';
import { calculateWinAmount } from './DisplayWheelSet';

const Game = () => {
  //some ideas for improvements
  //add storybook to ensure single responsibility
  //add react-testing-library tests e.g. last bet with win allows continued play
  //add drag and drop win configuration selector. e.g. drag bar, bar, bar and set a payout amount - save to local storage
  //add drag and drop wheel item selector
  //add payout odds for configuration sets - tell people how they work
  //add sliders for config values e.g. time for wheel to settle
  //add smoothing to moving items - greensock?
  //set to random
  //increase size of bet button
  //payline highlight
  //fix max zoom column drop
  //SignalR number of users
  //make the wheels accelarate and decelarate
  //add more interesting animations
  //fix bug where on a cherry win, other items animate
  const debug = false;
  const render = useRef(0);
  const [credit, setCredit] = useState(0);
  const insertCreditAmount = 1;
  const [customerAlert, setCustomerAlert] = useState("");
  const insertCredit = creditAmount => () => {
    setCustomerAlert("");
    setCredit(_ => _ + creditAmount);
  }
  const wheelIndexMax = 11; //todo: remove this and use DisplayWheelSet values.
  const [win, setWin] = useState();
  const [betSwitch, setBetSwitch] = useState(false);//todo: initialise only once
  const getRandomWheelIndex = () => Math.floor(Math.random() * wheelIndexMax);
  const getNextPosition = () => {
    return {
      left: getRandomWheelIndex(),
      center: getRandomWheelIndex(),
      right: getRandomWheelIndex()
    }
  };
  // useEffect(() => {
  //     if (win === undefined) {
  //         setWin(false);
  //     }
  //     console.log("win changed: " + win);
  //     //return () => {};
  // }, [win]);
  const spendAmount = 1;
  const reduceCredit = spendAmount => () => setCredit(_ => _ - spendAmount);
  const targetPosition = useRef();
  const winAmountRef = useRef(0);
  const testWins = [
    { left: 0, center: 4, right: 4 },//bar win
    { left: 1, center: 4, right: 2 },//bell bar bell win
    { left: 1, center: 5, right: 2 },//bell win
    { left: 3, center: 1, right: 3 },//orange win
    { left: 4, center: 2, right: 0 },//plum win
    { left: 2, center: 0, right: 1 },//cherry win 5
    { left: 2, center: 0, right: 4 },//cherry win 5
    { left: 0, center: 0, right: 1 },//cherry win 5
    { left: 2, center: 4, right: 1 },//cherry win 2
    { left: 0, center: 4, right: 1 },//cherry win 2
    { left: 2, center: 4, right: 4 },//cherry win 2
  ];
  const testWinIndex = useRef(0);
  const spendCredit = spendAmount => () => {
    //console.log('spend amount');
    if (credit > 0) {
      setCustomerAlert("");
      reduceCredit(spendAmount)();
      targetPosition.current = getNextPosition();
      targetPosition.current = testWins[testWinIndex.current];
      testWinIndex.current = (testWinIndex.current + 1) % testWins.length;
      setBetSwitch(_ => !_);//toggle the switch e.g. off - on, on - off
      setBetInProgress(() => true);
      setWin(false);
      winAmountRef.current = calculateWinAmount(targetPosition.current);//can this be async?
    } else {
      setCustomerAlert("No coins left to bet.");
    }
  }
  const [betInProgress, setBetInProgress] = useState(false);
  const betFinished = () => {
    setBetInProgress(() => false);
    if (winAmountRef.current > 0) {
      setWin(() => true);
      insertCredit(winAmountRef.current)();
    }
  };
  const [displayPayouts, setDisplayPayouts] = useState(false);
  const payouts = displayPayouts ? <DisplayPayouts /> : null;

  return (
    <DisplayCredit credit={credit} >
      {debug ? `Game: ${render.current++}` : null}
      <div className="row">
        <div className="col-sm-12 text-center">
          <button className="btn btn-primary col-sm-2" onClick={() => { setDisplayPayouts(_ => !_); }} disabled={betInProgress}>
            {displayPayouts ? "HIDE" : "SHOW"} PAYOUTS
          </button>
          &nbsp;
          <button className="btn btn-primary col-sm-2" onClick={insertCredit(insertCreditAmount)}>
            {insertCreditAmount > 1
              ? `INSERT ${insertCreditAmount} COINS`
              : "INSERT COIN"}
          </button>
        </div>
      </div>

      <RotateWheelSet
        betSwitch={betSwitch} callback={betFinished}
        startPosition={{
          left: 0,
          center: 0,
          right: 0
        }}
        credit={credit} setCredit={setCredit}
        targetPosition={targetPosition.current}
        win={winAmountRef.current > 0}
        debug={debug}
      />
      <div className="row">
        <div className="col-sm-4 text-center">
        </div>
        <div className="col-sm-4 text-center">
          <button className="btn btn-success btn-lg" onClick={spendCredit(spendAmount)} disabled={betInProgress}>
            BET
          </button>
        </div>
        <div className="col-sm-4 text-center">
          {customerAlert}
          <DisplayWin win={win} amount={winAmountRef.current} />
        </div>
      </div>
      {payouts}

    </DisplayCredit>
  );
}

export default Game;
