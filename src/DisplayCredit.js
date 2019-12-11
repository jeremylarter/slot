import React from 'react';

const DisplayCredit = (props) => {
  const message = props.credit > 0
    ? `Credit${props.credit > 1 ? "s" : ""}: ${props.credit}`
    : "Credit 0. Please insert credit to continue.";//todo: probably should just display zero until win check is finished.
  return (
    <div>
      {message}<br />
      {props.children}
    </div>
  );
}

export default DisplayCredit;
