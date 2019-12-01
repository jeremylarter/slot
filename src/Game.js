import React, {useState, useEffect} from 'react';
import RotateWheelSet from './RotateWheelSet'
import DisplayCredit from './DisplayCredit';
import DisplayWin from './DisplayWin';

const Game = () => {
    const [credit, setCredit] = useState(5);
    const insertCreditAmount = 1;
    const insertCredit = creditAmount => () => setCredit(_ => _ + creditAmount);

    const wheelIndexMax = 11; //todo: remove this and use DisplayWheelSet values.
    const [win, setWin] = useState();
    const betFinished = () => { setWin(_ => true); };
    const getRandomWheelIndex = () => Math.floor(Math.random() * wheelIndexMax);
    const getNextPosition = () => {
        setWin(false);
        return {
            left: getRandomWheelIndex(),
            center: getRandomWheelIndex(),
            right: getRandomWheelIndex()
        }
    };
    useEffect(() => {
        if (win === undefined) {
            setWin(false);
        }
        //console.log("win changed: " + win);
        return () => {
            ;
        };
    }, [win]);

    return (
        <DisplayCredit credit={credit} >
            <button onClick={insertCredit(insertCreditAmount)}>insert {insertCreditAmount} credit{insertCreditAmount > 1 ? "s" : ""}</button><br />

            <RotateWheelSet 
                startPosition={{
                    left: 0,
                    center: 0,
                    right: 0
                }}
                credit={credit} setCredit={setCredit}
                getNextPosition={getNextPosition}
                betFinished={betFinished}
            />
            <DisplayWin win={win} />
        </DisplayCredit>
    );
}

export default Game;
