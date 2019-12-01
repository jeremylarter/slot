import React, {useState, useRef, useEffect, useCallback} from 'react';
import DisplayWheelSet from './DisplayWheelSet';
import FramesPerSecond from './FramesPerSecond';

const RotateWheelSet = (props) => {
    const minDelay = 20;//number of milliseconds that it takes an item to move up one spot.
    const [timer, setTimer] = useState(minDelay);//todo: what is the value proposition for useState over useRef?
    const [spinCounter, setSpinCounter] = useState(0);
    const spinningRef = useRef();
    const requestRef = useRef();
    const functionRef = useRef();
    const dummyRef = useRef();
    const deltaRef = useRef({last:0, change:0});
    const loopMax = 10000;//infinite loop guard: maximum number of elapsed frames without settling on next position before we quit
    const wheelIndexMax = 11; //todo: remove this and use DisplayWheelSet values.

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
    const minWheelSpinTime = 100;//todo: change this to different intervals - 4000, 1000, 1000
    const deltaTime = useRef(0);
    const loop = useCallback( time => {
        deltaTime.current = time;
        functionRef.current += 1;//todo: rename this as loopGuard. When developing, we do not want an infinite loop.
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
        setTimer(() => Math.floor(deltaRef.current.change));
        if (deltaRef.current.change > minDelay) {
            deltaRef.current.last = time;
            const rightIncrement = wheelIncrement(positionRef.current.position.right % 11, positionRef.current.next.right, wheelsDeltaRef.current.timePassed.right);
            if (rightIncrement === 0) {
                //cannot stop just because right wheel timer is up, need to wait to right position is settled on.
                spinningRef.current = false;
            }
            positionRef.current.position = {
                left: positionRef.current.position.left + wheelIncrement(positionRef.current.position.left % 11, positionRef.current.next.left, wheelsDeltaRef.current.timePassed.left),
                center: positionRef.current.position.center + wheelIncrement(positionRef.current.position.center % 11, positionRef.current.next.center, wheelsDeltaRef.current.timePassed.center),
                right: positionRef.current.position.right + rightIncrement
            };
            setCurrentPosition(() => positionRef.current.position);
        }
        //todo: can we smooth out the scroll using css animation?
        if (spinningRef.current && functionRef.current < loopMax) {
            requestRef.current = window.requestAnimationFrame(loop);
        }
        dummyRef.current = spinCounter;//used to stop React complaining
    }, [spinCounter]);//end loop callback

    const cancelSpin = () => window.cancelAnimationFrame(requestRef.current);
    const spin = () => {
        //idea: use css scroll stop position and allow the user to see all the items on a wheel
        spinningRef.current = true;
        setSpinCounter(previous => previous + 1);//todo: what happens when overflow occurs? max float + 1?
        wheelsDeltaRef.current = initWheelsDeltaRef;
        //const comparisonPosition = {left: positionRef.current.position.left % 11, center: positionRef.current.position.center % 11, right: positionRef.current.position.right % 11};
        //console.log("current: ", comparisonPosition, positionRef.current.position);
        //positionRef.current.next = log("spin: ", getNextPosition)();
        positionRef.current.next = getNextPosition();
    }

    useEffect(() => {
        if (functionRef.current === undefined) {
            spinningRef.current = false;
        } else { //delay the loop until after first page load.
            requestRef.current = window.requestAnimationFrame(loop);
        }
        functionRef.current = 0;//todo: rename this as loopGuard. When developing, we do not want an infinite loop.

        return () => {
            //stop the animation when disposed
            window.cancelAnimationFrame(requestRef.current)
        };
    }, [loop]);
    const debug = false;
    const fps = <FramesPerSecond time={deltaTime.current} animationId={spinCounter} />;
    const debugOutput = `count: ${spinCounter} ${spinningRef.current ? "spinning" : "stopped"} ${timer} `;

    return (
        <div>
            <button onClick={cancelSpin} disabled={!spinningRef.current}>break</button><br />
            <button onClick={spin} disabled={spinningRef.current}>spin</button><br />
            {debug ? debugOutput : ""}
            {debug ? fps : ""}
            <DisplayWheelSet startPosition={currentPosition} debug={debug} />
        </div>
    );
}

export default RotateWheelSet;
