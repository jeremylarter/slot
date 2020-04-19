import React from 'react';

const DisplayCredit = (props) => {
  const message = props.credit > 0
    ? `${props.credit} Coin${props.credit > 1 ? "s" : ""}`
    : "Game over! Please insert a coin to play.";//todo: probably should just display zero until win check is finished.
  return (
    <>
      <div className="row">
        <div className="col-sm-12 text-right">{message}</div>
      </div>
      <div className="row">
        <div className="col-sm-12">
          {props.children}
        </div>
      </div>
    </>
  );
}

export default DisplayCredit;
