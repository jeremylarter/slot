import React, {useState} from 'react';
import RotateWheelSet from './RotateWheelSet'
import DisplayCredit from './DisplayCredit';

const Game = () => {
    const [credit, setCredit] = useState(5);
    const insertCreditAmount = 1;
    const insertCredit = creditAmount => () => setCredit(_ => _ + creditAmount);

    return (
        <DisplayCredit credit={credit} >
            <button onClick={insertCredit(insertCreditAmount)}>insert {insertCreditAmount} credit{insertCreditAmount > 1 ? "s" : ""}</button><br />

            <RotateWheelSet startPosition={{
            left: 0,
            center: 0,
            right: 0
            }} credit={credit} setCredit={setCredit} />
        </DisplayCredit>
    );
}

export default Game;
