import React, {useState, useRef} from 'react';
import RotateWheelSet from './RotateWheelSet'
import DisplayCredit from './DisplayCredit';
import DisplayWin from './DisplayWin';

const Game = () => {
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
        } else {
            setCustomerAlert("Please insert credit to continue.");
        }
    }
    const [betInProgress, setBetInProgress] = useState(false);
    const betFinished = () => {
        //console.log('target position found');
        setBetInProgress(() => false);
        setWin(() => true);
    };

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
            <DisplayWin win={win} />
        </DisplayCredit>
    );
}

export default Game;
