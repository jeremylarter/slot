import React, { memo, useRef } from 'react';
import { itemType } from './DisplayWheelSet';
import Bar from './Bar';
import Bell from './Bell';
import Cherry from './Cherry';
import Orange from './Orange';
import Plum from './Plum';
import Any from './Any';

const DisplayItem = ({ mykey, win, ...props }) => {
  var item = <Bar win={win} mykey={mykey} />;
  switch (props.item) {
    case itemType.bar:
      item = <Bar win={win} mykey={mykey} />;
      break;
    case itemType.bell:
      item = <Bell win={win} mykey={mykey} />;
      break;
    case itemType.orange:
      item = <Orange win={win} mykey={mykey} />;
      break;
    case itemType.plum:
      item = <Plum win={win} mykey={mykey} />;
      break;
    case itemType.cherry:
      item = <Cherry win={win} mykey={mykey} />;
      break;
    default:
      item = <Any win={win} text={props.text} mykey={mykey} />;
  }
  const render = useRef(0);
  return (
    <div>
      {props.debug ? render.current++ : null}
      {item}
    </div>
  );
}

export default memo(DisplayItem);
