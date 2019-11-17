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
    const [loopMax, setLoopMax] = useState(50);

    const loop = useCallback( time => {
        setTimer(() => time);
        functionRef.current += 1;
        //output will be displayed correctly, but it cannot be accessed here because it will just be output = "a" as initialised.
        //so, instead use functionRef.current which is set in memory and will not trigger a re-render
        const currentIndex = functionRef.current;
        setCurrentPosition(_ => ({
            left: currentIndex,
            center: currentIndex,
            right: currentIndex
        }));
        console.log(functionRef.current);

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
        if (requestRef.current === undefined) {
            functionRef.current = 0;
        }
        //todo: how can we delay the start until the button is pressed?
        requestRef.current = window.requestAnimationFrame(loop);

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
