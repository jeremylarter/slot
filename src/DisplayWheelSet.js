import React, {useRef, memo} from 'react';
import DisplayItem from './DisplayItem';

export const itemType = Object.freeze({"bar":1, "bell":2, "cherry":3, "orange":4, "plum":5});

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

export const calculateWinAmount = wheelIndex => {
    const getItemTypes = wheelIndex => {
        return [
            wheel.left[wheelIndex.left],
            wheel.center[wheelIndex.center],
            wheel.right[wheelIndex.right]
        ];
    };
    const allMatching = payLine => {
        return payLine[0] === payLine[1] && payLine[1] === payLine[2];
    };
    const payLine = getItemTypes(wheelIndex);
    const left = 0, center = 1, right = 2;
    if (payLine[left] === itemType.cherry || payLine[right] === itemType.cherry) {
        if (payLine[center] === itemType.cherry) {
            return 5;
        }
        return 2;
    }
    if (payLine[left] === itemType.bell && 
        payLine[center] === itemType.bar && 
        payLine[right] === itemType.bell) {
        return 25;
    }
    if (allMatching(payLine)) {
        switch (payLine[left]) {
            case itemType.plum:
                return 10;
            case itemType.orange:
                return 14;
            case itemType.bell:
                return 20;
            case itemType.bar:
                return 50;
            default:
                return 5;//should never get here, but only other option is 3 x cherry
        }
    }
    return 0;
}


const DisplayWheelSet = (props) => {
    // let index=1;
    const wheelSet = [
        {currentWheel: wheel.left, currentPosition: props.startPosition.left, key: 'leftWheel', maxItems: wheel.left.length},
        {currentWheel: wheel.center, currentPosition: props.startPosition.center, key: 'centerWheel', maxItems: wheel.center.length},
        {currentWheel: wheel.right, currentPosition: props.startPosition.right, key: 'rightWheel', maxItems: wheel.right.length}
    ];
    //flattened -1 + 11 % 11 = 10, 0 + 11 % 11 = 0, 1 + 11 % 11 = 1
    const offsetList = [10, 0, 1];//deal with the wrap around when subtracting from a position
    //say position = 0, above = 0 + 10 % 11 =10, below = 0 + 1 % 11 = 1
    //say position = 1, above = 1 + 10 % 11 = 0, below = 1 + 1 % 11 = 2
    //say position = 2, above = 2 + 10 % 11 = 1, below = 2 + 1 % 11 = 3
    //say position = 3, above = 3 + 10 % 11 = 2, below = 3 + 1 % 11 = 4
    //say position = 4, above = 4 + 10 % 11 = 3, below = 4 + 1 % 11 = 5
    //say position = 5, above = 5 + 10 % 11 = 4, below = 5 + 1 % 11 = 6
    //say position = 6, above = 6 + 10 % 11 = 5, below = 6 + 1 % 11 = 7
    //say position = 7, above = 7 + 10 % 11 = 6, below = 7 + 1 % 11 = 8
    //say position = 8, above = 8 + 10 % 11 = 7, below = 8 + 1 % 11 = 9
    //say position = 9, above = 9 + 10 % 11 = 8, below = 9 + 1 % 11 =10
    //say position =10, above =10 + 10 % 11 = 9, below =10 + 1 % 11 = 0
    const render = useRef(0);
    const getWheelIndex = (position, offset, maxItems) => (position + offset) % maxItems;
    return (
        <div>
            <p>{props.debug ? render.current++ : ""}</p>
            {wheelSet.map(_ => 
            <ul key={_.key} style={{ listStyleType:"none", display: "inline-block" }}>
                {offsetList.map( offset => 
                <li key={_.key + offset}>
                    <DisplayItem item={_.currentWheel[getWheelIndex(_.currentPosition, offset, _.maxItems)]}
                        win={props.win && offset === offsetList[1]}
                        mykey={"item" + _.key + offset}
                        debug={props.debug} />
                </li>)}
            </ul>)}
            
            {/* All items:
            {wheel.left.map(item => <DisplayItem key={"wl" + index++} item={item} />)}
            {wheel.center.map(item => <DisplayItem key={"wc" + index++} item={item} />)}
            {wheel.right.map(item => <DisplayItem key={"wr" + index++} item={item} />)} */}
        </div>
    );
}

export default memo(DisplayWheelSet);
