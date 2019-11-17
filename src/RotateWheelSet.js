import React, {useState, useRef, useEffect, useCallback} from 'react';
import DisplayWheelSet from './DisplayWheelSet';

const RotateWheelSet = (props) => {
    //todo: use the props.startPosition of the caller
    const [timer, setTimer] = useState(0);
    const [currentPosition, setCurrentPosition] = useState({
        left: 1,
        center: 1,
        right: 1
      });
    const requestRef = useRef();
    const functionRef = useRef();
    const [loopMax, setLoopMax] = useState(0);

    const loop = useCallback( time => {
        setTimer(() => time);
        functionRef.current += 1;
        const currentIndex = functionRef.current;
        setCurrentPosition(_ => ({
            left: currentIndex,
            center: currentIndex,
            right: currentIndex
        }));

        if (functionRef.current < loopMax) {
            requestRef.current = window.requestAnimationFrame(loop);
        }
    }, [loopMax]);

    const cancelSpin = () => {
        window.cancelAnimationFrame(requestRef.current)
    }

    const spin = () => {
        //todo: only allow another spin after the current spin has finished.
        setLoopMax(previous => previous + 50);
    }

    useEffect(() => {
        if (functionRef.current === undefined) {
            functionRef.current = 0;
        } else { //delay the loop until after first page load.
            requestRef.current = window.requestAnimationFrame(loop);
        }

        return () => {
            //stop the animation when disposed
            window.cancelAnimationFrame(requestRef.current)
        };
    }, [loop]);

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
