import React from 'react';

const DisplayWin = (props) => {
    return (
        props.win ? <div>You win!</div> : <div></div>
    );
}

export default DisplayWin;
