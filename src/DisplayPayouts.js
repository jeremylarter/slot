import React from 'react';
import DisplayItem from './DisplayItem';
import { itemType } from './DisplayWheelSet';

const DisplayPayouts = () => {
    //idea: display line by line in a loop after a delay
    //display in a scaled panel to the side
    return (
        <div>
            <ul style={{ listStyleType:"none", display: "inline-block" }}>
                <li><DisplayItem item={itemType.any} /></li>
                <li><DisplayItem item={itemType.cherry} /></li>
                <li><DisplayItem item={itemType.cherry} /></li>
                <li><DisplayItem item={itemType.cherry} /></li>
                <li><DisplayItem item={itemType.any} /></li>
                <li><DisplayItem item={itemType.cherry} /></li>
                <li><DisplayItem item={itemType.plum} /></li>
                <li><DisplayItem item={itemType.orange} /></li>
                <li><DisplayItem item={itemType.bell} /></li>
                <li><DisplayItem item={itemType.bell} /></li>
                <li><DisplayItem item={itemType.bar} /></li>
            </ul>
            <ul style={{ listStyleType:"none", display: "inline-block" }}>
                <li><DisplayItem item={itemType.any} /></li>
                <li><DisplayItem item={itemType.any} /></li>
                <li><DisplayItem item={itemType.any} /></li>
                <li><DisplayItem item={itemType.cherry} /></li>
                <li><DisplayItem item={itemType.cherry} /></li>
                <li><DisplayItem item={itemType.cherry} /></li>
                <li><DisplayItem item={itemType.plum} /></li>
                <li><DisplayItem item={itemType.orange} /></li>
                <li><DisplayItem item={itemType.bell} /></li>
                <li><DisplayItem item={itemType.bar} /></li>
                <li><DisplayItem item={itemType.bar} /></li>
            </ul>
            <ul style={{ listStyleType:"none", display: "inline-block" }}>
                <li><DisplayItem item={itemType.cherry} /></li>
                <li><DisplayItem item={itemType.any} /></li>
                <li><DisplayItem item={itemType.cherry} /></li>
                <li><DisplayItem item={itemType.any} /></li>
                <li><DisplayItem item={itemType.cherry} /></li>
                <li><DisplayItem item={itemType.cherry} /></li>
                <li><DisplayItem item={itemType.plum} /></li>
                <li><DisplayItem item={itemType.orange} /></li>
                <li><DisplayItem item={itemType.bell} /></li>
                <li><DisplayItem item={itemType.bell} /></li>
                <li><DisplayItem item={itemType.bar} /></li>
            </ul>
            <ul style={{ listStyleType:"none", display: "inline-block" }}>
                <li><DisplayItem item={itemType.any} text="2" /></li>
                <li><DisplayItem item={itemType.any} text="2" /></li>
                <li><DisplayItem item={itemType.any} text="2" /></li>
                <li><DisplayItem item={itemType.any} text="5" /></li>
                <li><DisplayItem item={itemType.any} text="5" /></li>
                <li><DisplayItem item={itemType.any} text="5" /></li>
                <li><DisplayItem item={itemType.any} text="10" /></li>
                <li><DisplayItem item={itemType.any} text="14" /></li>
                <li><DisplayItem item={itemType.any} text="20" /></li>
                <li><DisplayItem item={itemType.any} text="25" /></li>
                <li><DisplayItem item={itemType.any} text="50" /></li>
            </ul>
        </div>
    );
}

export default DisplayPayouts;
