import React, {useState, useRef, useEffect, useCallback} from 'react';
import DisplayWheelSet from './DisplayWheelSet';

const RotateWheelSet = (props) => {
    const [timer, setTimer] = useState(0);
    const requestRef = useRef();
    const functionRef = useRef();
    const deltaRef = useRef({last:0, change:0});
    const [loopMax, setLoopMax] = useState(0);
    const minDelay = 100;
    const minItemMoves = 20;
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
    const loop = useCallback( time => {
        const wheelIncrement = (currentIndex, nextIndex, wheelTimePassed) => currentIndex === nextIndex && wheelTimePassed ? 0 : 1;
        deltaRef.current.change = time - deltaRef.current.last;
        setTimer(() => deltaRef.current.change);
        if (deltaRef.current.change > minDelay) {
            functionRef.current += 1;//todo: remove this? maybe use as a flag for minimum number of iterations?
            deltaRef.current.last = time;
            positionRef.current.position = {
                left: positionRef.current.position.left + wheelIncrement(positionRef.current.position.left % 11, positionRef.current.next.left, true),
                center: positionRef.current.position.center + wheelIncrement(positionRef.current.position.center % 11, positionRef.current.next.center, true),
                right: positionRef.current.position.right + wheelIncrement(positionRef.current.position.right % 11, positionRef.current.next.right, true)
            };
            setCurrentPosition(() => positionRef.current.position);
            // setCurrentPosition(_ => ({
            //     left: _.left + wheelIncrement(_.left % 11, positionRef.current.next.left, true),
            //     center: _.center + wheelIncrement(_.center % 11, positionRef.current.next.center, true),
            //     right: _.right + wheelIncrement(_.right % 11, positionRef.current.next.right, true)
            // }));
            //const wheelIncrement = (currentIndex, nextIndex, wheelTimePassed) => {
            //    console.log("current / next / bool ", currentIndex, nextIndex, wheelTimePassed);
            //    return currentIndex === nextIndex && wheelTimePassed ? 0 : 1;
            //};
            // console.log("before setCurrentPosition: ", nextPositionRef.current);
            // setCurrentPosition(_ => {
            //     const left = _.left % 11;
            //     const nextLeft = nextPositionRef.current.left;
            //     const newLeft = _.left + wheelIncrement(left, nextLeft, true);
            //     console.log("setCurrentPosition: ", left, nextLeft, newLeft);
            //     return {
            //     left: newLeft,
            //     center: _.center + wheelIncrement(_.center % 11, nextPositionRef.current.center, true),
            //     right: _.right + wheelIncrement(_.right % 11, nextPositionRef.current.right, true)
            // }});
        }
        //todo: can we smooth out the scroll using css animation?
        if (functionRef.current < loopMax) {
            requestRef.current = window.requestAnimationFrame(loop);
        }
    }, [loopMax, positionRef]);

    const cancelSpin = () => {
        window.cancelAnimationFrame(requestRef.current)
    }
    const spin = () => {
        //todo: only allow another spin after the current spin has finished.
        //idea: use css scroll stop position and allow the user to see all the items on a wheel
        setLoopMax(previous => previous + minItemMoves);
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
