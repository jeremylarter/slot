import React from 'react';
import { itemType } from './DisplayWheelSet';
import Bar from './Bar';
import Bell from './Bell';
import Cherry from './Cherry';
import Orange from './Orange';
import Plum from './Plum';

const DisplayItem = (props) => {
    var item = <Bar />;
    switch (props.item) {
        case itemType.bar:
            item = <Bar />;
            break;
        case itemType.bell:
            item = <Bell />;
            break;
        case itemType.orange:
            item = <Orange />;
            break;
        case itemType.plum:
            item = <Plum />;
            break;
        default:
            item = <Cherry />

    }
    return (
        <div>
            {item}
        </div>
    );
}

export default DisplayItem;
