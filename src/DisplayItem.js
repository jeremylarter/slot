import React, {memo, useRef} from 'react';
import { itemType } from './DisplayWheelSet';
import Bar from './Bar';
import Bell from './Bell';
import Cherry from './Cherry';
import Orange from './Orange';
import Plum from './Plum';
import Any from './Any';

const DisplayItem = (props) => {
    var item = <Bar win={props.win} />;
    switch (props.item) {
        case itemType.bar:
            item = <Bar win={props.win} />;
            break;
        case itemType.bell:
            item = <Bell win={props.win} />;
            break;
        case itemType.orange:
            item = <Orange win={props.win} />;
            break;
        case itemType.plum:
            item = <Plum win={props.win} />;
            break;
        case itemType.cherry:
            item = <Cherry win={props.win} />;
            break;
        default:
            item = <Any win={props.win} text={props.text} />;
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
