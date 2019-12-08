import React from 'react';

const DisplayWin = (props) => {
    return (
        props.win ? <div>You win! {props.amount} credits added.</div> : <div>&nbsp;</div>
    );
}

export default DisplayWin;
