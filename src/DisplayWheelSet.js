import React from 'react';
import DisplayItem from './DisplayItem';

const itemType = Object.freeze({"bar":1, "bell":2, "cherry":3, "orange":4, "plum":5});

const wheel = {
    left: [
        itemType.bar,
        itemType.bell,
        itemType.cherry,
        itemType.orange,
        itemType.plum,
        itemType.cherry,
        itemType.orange,
        itemType.cherry,
        itemType.plum,
        itemType.bar,
        itemType.cherry
    ],
    center: [
        itemType.cherry,
        itemType.orange,
        itemType.plum,
        itemType.cherry,
        itemType.bar,
        itemType.bell,
        itemType.orange,
        itemType.bar,
        itemType.plum,
        itemType.bell,
        itemType.plum    
    ],
    right: [
        itemType.plum,
        itemType.cherry,
        itemType.bell,
        itemType.orange,
        itemType.bar,
        itemType.cherry,
        itemType.plum,
        itemType.orange,
        itemType.cherry,
        itemType.cherry,
        itemType.orange        
    ]
};
    
const DisplayWheelSet = (props) => {
    let index=1;
    return (
        <div>
            3x3 Display
            <ul>
                <li><DisplayItem item={wheel.left[props.startPosition.left - 1]} /></li>
                <li><DisplayItem item={wheel.left[props.startPosition.left]} /></li>
                <li><DisplayItem item={wheel.left[props.startPosition.left + 1]} /></li>
            </ul>
            <ul>
                <li><DisplayItem item={wheel.center[props.startPosition.center - 1]} /></li>
                <li><DisplayItem item={wheel.center[props.startPosition.center]} /></li>
                <li><DisplayItem item={wheel.center[props.startPosition.center + 1]} /></li>
            </ul>
            <ul>
                <li><DisplayItem item={wheel.right[props.startPosition.right - 1]} /></li>
                <li><DisplayItem item={wheel.right[props.startPosition.right]} /></li>
                <li><DisplayItem item={wheel.right[props.startPosition.right + 1]} /></li>
            </ul>
            
            All items:
            {wheel.left.map(item => <DisplayItem key={"wl" + index++} item={item} />)}
            {wheel.center.map(item => <DisplayItem key={"wc" + index++} item={item} />)}
            {wheel.right.map(item => <DisplayItem key={"wr" + index++} item={item} />)}
        </div>
);
}

export default DisplayWheelSet;
