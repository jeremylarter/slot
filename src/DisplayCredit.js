import React from 'react';

const DisplayCredit = (props) => {
  const message = props.credit > 0
    ? `Credit${props.credit > 1 ? "s" : ""}: ${props.credit}`
    : "Credit 0. Please insert credit to continue.";//todo: probably should just display zero until win check is finished.
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
