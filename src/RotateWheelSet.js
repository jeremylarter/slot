import React, {useState, useRef, useEffect, useCallback} from 'react';
import DisplayWheelSet from './DisplayWheelSet';

const RotateWheelSet = (props) => {
    const [timer, setTimer] = useState(0);
    const requestRef = useRef();
    const functionRef = useRef();
    const deltaRef = useRef({last:0, change:0});
    const [loopMax, setLoopMax] = useState(0);
    const minDelay = 100;
    const minItemMoves = 1000;//todo: this does not make sense anymore. If the wheels have not settled, it could lead to wrong display.
    const wheelIndexMax = 11; //todo: remove this and use DisplayWheelSet values.
    const log = (message, fn) => {//decorator
        return () => {
            const result = fn();
            console.log(message, result);
            return result;
        }
    }
    const getRandomWheelIndex = () => Math.floor(Math.random() * wheelIndexMax);
    const getNextPosition = () => ({
        left: getRandomWheelIndex(),
        center: getRandomWheelIndex(),
        right: getRandomWheelIndex()
    });
    const [currentPosition, setCurrentPosition] = useState(props.startPosition);
    //think of positionRef like a state shadow model available outside of render cycles.
    const positionRef = useRef({position: props.startPosition, next: getNextPosition()});
    const initTimePassed = {left: false, center: false, right: false};
    const initWheelsDeltaRef = {last:0, change:0, timePassed: initTimePassed};
    const wheelsDeltaRef = useRef(initWheelsDeltaRef);
    const minWheelSpinTime = 2000;//todo: change this to different intervals - 4000, 1000, 1000
    const loop = useCallback( time => {
        const wheelIncrement = (currentIndex, nextIndex, wheelTimePassed) => currentIndex === nextIndex && wheelTimePassed ? 0 : 1;
        if (wheelsDeltaRef.current.last === 0) {
            //first iteration, the change should be zero
            wheelsDeltaRef.current.last = time;
        }
        deltaRef.current.change = time - deltaRef.current.last;
        wheelsDeltaRef.current.change = time - wheelsDeltaRef.current.last;
        if (wheelsDeltaRef.current.change > minWheelSpinTime) {
            //a wheel can stop now
            wheelsDeltaRef.current.last = time;
            if (!wheelsDeltaRef.current.timePassed.left) {
                wheelsDeltaRef.current.timePassed.left = true;
            } else {
                //center or right wheel
                if (!wheelsDeltaRef.current.timePassed.center) {
                    wheelsDeltaRef.current.timePassed.center = true;
                } else {
                    //right
                    wheelsDeltaRef.current.timePassed.right = true;
                }
            }
        }
        setTimer(() => deltaRef.current.change);
        if (deltaRef.current.change > minDelay) {
            functionRef.current += 1;//todo: remove this? maybe use as a flag for minimum number of iterations?
            deltaRef.current.last = time;
            const rightIncrement = wheelIncrement(positionRef.current.position.right % 11, positionRef.current.next.right, wheelsDeltaRef.current.timePassed.right);
            if (rightIncrement === 0) {
                functionRef.current = loopMax;//todo: this is not readable. We are setting a different loop exit condition.
            }
            positionRef.current.position = {
                left: positionRef.current.position.left + wheelIncrement(positionRef.current.position.left % 11, positionRef.current.next.left, wheelsDeltaRef.current.timePassed.left),
                center: positionRef.current.position.center + wheelIncrement(positionRef.current.position.center % 11, positionRef.current.next.center, wheelsDeltaRef.current.timePassed.center),
                right: positionRef.current.position.right + rightIncrement
            };
            setCurrentPosition(() => positionRef.current.position);
        }
        //todo: can we smooth out the scroll using css animation?
        //todo: cannot stop just because right wheel timer is up, need to wait to position is settled on.
        if (functionRef.current < loopMax) {
            requestRef.current = window.requestAnimationFrame(loop);
        }
    }, [loopMax, positionRef]);

    const cancelSpin = () => window.cancelAnimationFrame(requestRef.current);

    const spin = () => {
        //todo: only allow another spin after the current spin has finished.
        //idea: use css scroll stop position and allow the user to see all the items on a wheel
        setLoopMax(previous => previous + minItemMoves);
        wheelsDeltaRef.current = initWheelsDeltaRef;
        const comparisonPosition = {left: positionRef.current.position.left % 11, center: positionRef.current.position.center % 11, right: positionRef.current.position.right % 11};
        console.log("current: ", comparisonPosition, positionRef.current.position);
        positionRef.current.next = log("spin: ", getNextPosition)();
    }

    useEffect(() => {
        if (functionRef.current === undefined) {
            functionRef.current = props.startPosition.left;//1
        } else { //delay the loop until after first page load.
            requestRef.current = window.requestAnimationFrame(loop);
        }

        return () => {
            //stop the animation when disposed
            window.cancelAnimationFrame(requestRef.current)
        };
    }, [loop, props.startPosition.left]);

    return (
        <div>
            <button onClick={cancelSpin}>cancel</button><br />
            <button onClick={spin}>spin</button><br />
            {timer}
            <DisplayWheelSet startPosition={currentPosition} />
        </div>
    );
}

export default RotateWheelSet;
