import React, {useState, useRef} from 'react';
import RotateWheelSet from './RotateWheelSet'
import DisplayCredit from './DisplayCredit';
import DisplayWin from './DisplayWin';
import DisplayPayouts from './DisplayPayouts';

const Game = () => {
    //some ideas for improvements
    //add storybook to ensure single responsibility
    //add react-testing-library tests e.g. last bet with win allows continued play
    //add drag and drop win configuration selector. e.g. drag bar, bar, bar and set a payout amount - save to local storage
    //add drag and drop wheel item selector
    //add payout odds for configuration sets - tell people how they work
    //add sliders for config values e.g. time for wheel to settle
    //add smoothing to moving items - greensock?
    const debug = false;
    const render = useRef(0);
    const [credit, setCredit] = useState(2);
    const insertCreditAmount = 1;
    const insertCredit = creditAmount => () => setCredit(_ => _ + creditAmount);

    const wheelIndexMax = 11; //todo: remove this and use DisplayWheelSet values.
    const [win, setWin] = useState();
    const [betSwitch, setBetSwitch] = useState(false);//todo: initialise only once
    const getRandomWheelIndex = () => Math.floor(Math.random() * wheelIndexMax);
    const getNextPosition = () => {
        //console.log('getNextPosition');
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
    const [customerAlert, setCustomerAlert] = useState("");
    const targetPosition = useRef();
    const spendCredit = spendAmount => () => {
        //console.log('spend amount');
        if (credit > 0) {
            setCustomerAlert("");
            reduceCredit(spendAmount)();
            targetPosition.current = getNextPosition();
            setBetSwitch(_ => !_);//toggle the switch e.g. off - on, on - off
            setBetInProgress(() => true);
            setWin(false);
        } else {
            setCustomerAlert("Please insert credit to continue.");
        }
    }
    const [betInProgress, setBetInProgress] = useState(false);
    const betFinished = () => {
        //console.log('target position found');
        //todo: calculate the win amount, if any
        setBetInProgress(() => false);
        if (Math.random() > 0.5) {
            setWin(() => true);
            insertCredit(1)();
        }
    };
    const [displayPayouts, setDisplayPayouts] = useState(false);
    const payouts = displayPayouts ? <DisplayPayouts /> : null;

    return (
        <DisplayCredit credit={credit} >
            {debug ? `Game: ${render.current++}` : null}
            <button onClick={insertCredit(insertCreditAmount)}>insert {insertCreditAmount} credit{insertCreditAmount > 1 ? "s" : ""}</button><br />
            <button onClick={spendCredit(spendAmount)} disabled={betInProgress}>bet</button><br />{customerAlert}

            <RotateWheelSet 
                betSwitch={betSwitch} callback={betFinished}
                startPosition={{
                    left: 0,
                    center: 0,
                    right: 0
                }}
                credit={credit} setCredit={setCredit}
                targetPosition={targetPosition.current}
                debug={debug}
            />
            <DisplayWin win={win} amount={1} />
            <button onClick={() => {setDisplayPayouts(_ => !_);}} disabled={betInProgress}>payouts</button><br />
            {payouts}
        </DisplayCredit>
    );
}

export default Game;
