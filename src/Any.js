import React from 'react';

const Any = ({ text, ...props }) => {
  const optionalText = text !== undefined ? '' + text : "";
  const className = optionalText.length === 1 ? "single-digit" : "double-digit";
  //there seems to be a bug with a parameterised text element with the path svg - defs - symbol - g - text
  return (
    <div>
      <svg viewBox="0.5 0 30 30" width="90px" height="90px" xmlns="http://www.w3.org/2000/svg" xmlnsXlink="http://www.w3.org/1999/xlink">
        <defs>
          <symbol id="symbol-any" viewBox="0.5 0 30 30">
            <g>
              <path d="M 0,0 V 30 H 30 V 0z" className="any-background" />
            </g>
          </symbol>
        </defs>
        <title>any symbol instance</title>
        <desc>Contains graphic to take up the space of an item with optional text.</desc>
        <style>{`
                    .any-background {stroke: #000000; paint-order: stroke; fill: rgb(0, 0, 0);}
                    .single-digit { font: bold 25px sans-serif; fill: silver; text-anchor: middle; }
                    .double-digit { font: bold 25px sans-serif; fill: gold; text-anchor: middle; }
                    `}
        </style>
        <use width="30" height="30" transform="matrix(1, 0, 0, 1, 0, 0)" xlinkHref="#symbol-any" />
        <text x="50%" y="80%" className={className}>{optionalText}</text>
      </svg>
    </div>
  );
}

export default Any;
