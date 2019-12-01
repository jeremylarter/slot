import React from 'react';

const DisplayCredit = (props) => {

    return (
        <div>
            Credit{props.credit > 1 ? "s" : ""}: {props.credit}<br />
            {props.children}
        </div>
    );
}

export default DisplayCredit;
