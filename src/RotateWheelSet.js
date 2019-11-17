import React, {useState, useRef, useEffect, useCallback} from 'react';
import DisplayWheelSet from './DisplayWheelSet';

const RotateWheelSet = (props) => {
    const [output, setOutput] = useState("achoo");
    const [timer, setTimer] = useState(0);
    const [currentPosition, setCurrentPosition] = useState({
        left: 1,
        center: 1,
        right: 1
      });
    const requestRef = useRef();
    const functionRef = useRef();
    const loopMax = 50;

    const loop = useCallback( time => {
        setOutput(previous => previous + "o");
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
        if (functionRef.current < loopMax) {
            requestRef.current = window.requestAnimationFrame(loop);
        }
    }, []);

    const cancelCounter = () => {
        window.cancelAnimationFrame(requestRef.current)
    }
    useEffect(() => {
        if (requestRef.current === undefined) {
            functionRef.current = 0;
            requestRef.current = window.requestAnimationFrame(loop);
        }
        return () => {
            //stop the animation when disposed
            window.cancelAnimationFrame(requestRef.current)
        };
    }, [loop]);

    return (
        <div>
            <button onClick={cancelCounter}>cancel</button><br />
            {output}<br />
            {timer}
            <DisplayWheelSet startPosition={currentPosition} />
        </div>
    );
}

export default RotateWheelSet;
