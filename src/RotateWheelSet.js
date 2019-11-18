import React, {useState, useRef, useEffect, useCallback} from 'react';
import DisplayWheelSet from './DisplayWheelSet';

const RotateWheelSet = (props) => {
    const [timer, setTimer] = useState(0);
    const [currentPosition, setCurrentPosition] = useState(props.startPosition);
    const requestRef = useRef();
    const functionRef = useRef();
    const deltaRef = useRef({last:0, now:0, change:0});
    const [loopMax, setLoopMax] = useState(0);
    const minDelay = 100;
    const minItemMoves = 20;

    const loop = useCallback( time => {
        deltaRef.current.now = time;//refactor out?
        deltaRef.current.change = deltaRef.current.now - deltaRef.current.last;
        //setTimer(() => time);
        setTimer(() => deltaRef.current.change);
        if (deltaRef.current.change > minDelay) {
            functionRef.current += 1;
            const currentIndex = functionRef.current;
            deltaRef.current.last = time;
            setCurrentPosition(_ => ({
                left: currentIndex,
                center: currentIndex,
                right: currentIndex
            }));
        }
        //todo: can we smooth out the scroll using css animation?
        if (functionRef.current < loopMax) {
            requestRef.current = window.requestAnimationFrame(loop);
        }
    }, [loopMax]);

    const cancelSpin = () => {
        window.cancelAnimationFrame(requestRef.current)
    }

    const spin = () => {
        //todo: only allow another spin after the current spin has finished.
        //idea: use css scroll stop position and allow the user to see all the items on a wheel
        setLoopMax(previous => previous + minItemMoves);
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