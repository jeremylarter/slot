import React from 'react';

const DisplayWin = (props) => {
  return (
    <div className="row">
      <div className="col-sm-12 text-right">
        <div className="text-success">{props.win ? "You win! " + props.amount + " coins added." : ""}</div>
      </div>
    </div>
  );
}

export default DisplayWin;
