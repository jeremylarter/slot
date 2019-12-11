import React, { useState, useRef, useEffect, memo } from 'react';
import DisplayWheelSet from './DisplayWheelSet';
import FramesPerSecond from './FramesPerSecond';

const RotateWheelSet = ({ targetPosition, betSwitch, callback, ...props }) => {
  const minDelay = 90;//number of milliseconds that it takes an item to move up one spot.
  //it might look better if the minDelay is not constant e.g. wind up to fastest - steady - wind down to stop
  const wheelIndex = useRef(0);
  const [timer, setTimer] = useState(minDelay);//todo: what is the value proposition for useState over useRef?
  const [spinCounter, setSpinCounter] = useState(0);
  const spinningRef = useRef();
  const requestRef = useRef();
  const loopGuardRef = useRef(0);
  const deltaRef = useRef({ last: 0, change: 0 });
  const loopMax = 5000;//infinite loop guard: maximum number of elapsed frames without settling on next position before we quit

  const [currentPosition, setCurrentPosition] = useState(props.startPosition);
  //think of positionRef like a state shadow model available outside of render cycles.
  const positionRef = useRef({ position: props.startPosition, next: undefined });
  const initTimePassed = { left: false, center: false, right: false };
  const initWheelsDeltaRef = { last: 0, change: 0, timePassed: initTimePassed };
  const wheelsDeltaRef = useRef(initWheelsDeltaRef);
  const deltaTime = useRef(0);
  const flipped = useRef();
  const waitForWheelStop = useRef({ left: false, center: false, right: false });
  const settleRef = useRef([0, 0, 0]);
  const cancelSpin = () => window.cancelAnimationFrame(requestRef.current);
  //https://reactjs.org/docs/composition-vs-inheritance.html
  //https://w3bits.com/svg-sprites/
  //https://bl.ocks.org/helderdarocha/8b28505082bf1c81977d7dec797686c7
  //https://reactjs.org/docs/hooks-effect.html
  //https://daveceddia.com/useeffect-hook-examples/
  //https://www.javascriptstuff.com/component-communication/#3-callback-functions
  //https://reactjs.org/docs/context.html
  useEffect(() => {
    const minWheelSpinTime = [2500, 800, 1600];
    const loop = time => {
      //console.log('loop');
      //console.log(time);
      deltaTime.current = time;
      if (wheelsDeltaRef.current.last === 0) {
        wheelsDeltaRef.current.last = time;//first iteration, the change should be zero
      }
      deltaRef.current.change = time - deltaRef.current.last;
      wheelsDeltaRef.current.change = time - wheelsDeltaRef.current.last;
      //console.log("wheelsDeltaRef.current.change: ", wheelsDeltaRef.current.change);
      if (wheelsDeltaRef.current.change > minWheelSpinTime[wheelIndex.current] &&
        !waitForWheelStop.current.left &&
        !waitForWheelStop.current.center &&
        !waitForWheelStop.current.right) {
        //console.log('stopping wheel from now', wheelsDeltaRef.current.change);
        wheelIndex.current = (wheelIndex.current + 1) % minWheelSpinTime.length;
        if (!wheelsDeltaRef.current.timePassed.left) {
          wheelsDeltaRef.current.timePassed.left = true;
          waitForWheelStop.current.left = true;
        } else {
          //center or right wheel
          if (!wheelsDeltaRef.current.timePassed.center) {
            wheelsDeltaRef.current.timePassed.center = true;
            waitForWheelStop.current.center = true;
          } else {
            //right
            wheelsDeltaRef.current.timePassed.right = true;
            waitForWheelStop.current.right = true;
          }
        }
      }
      setTimer(() => Math.floor(deltaRef.current.change));
      const hasNext = positionRef.current.next;
      const wheelIncrement = (currentIndex, nextIndex, wheelTimePassed) => currentIndex === nextIndex && wheelTimePassed ? 0 : 1;
      if (deltaRef.current.change > minDelay && hasNext) {
        deltaRef.current.last = time;
        const leftIncrement = wheelIncrement(positionRef.current.position.left % 11, positionRef.current.next.left, wheelsDeltaRef.current.timePassed.left);
        const centerIncrement = wheelIncrement(positionRef.current.position.center % 11, positionRef.current.next.center, wheelsDeltaRef.current.timePassed.center);
        const rightIncrement = wheelIncrement(positionRef.current.position.right % 11, positionRef.current.next.right, wheelsDeltaRef.current.timePassed.right);
        //check for stop and reset min wait for the next wheel
        if (waitForWheelStop.current.left && leftIncrement === 0 && centerIncrement === 1) {
          wheelsDeltaRef.current.last = time;
          settleRef.current[0] = Math.floor(wheelsDeltaRef.current.change);
          waitForWheelStop.current.left = false;
        }
        if (waitForWheelStop.current.center && centerIncrement === 0 && rightIncrement === 1) {
          wheelsDeltaRef.current.last = time;
          settleRef.current[1] = Math.floor(wheelsDeltaRef.current.change);
          waitForWheelStop.current.center = false;
        }

        if (rightIncrement === 0) {
          //wait to right position is settled on before stopping
          spinningRef.current = false;
          settleRef.current[2] = Math.floor(wheelsDeltaRef.current.change);
          waitForWheelStop.current.right = false;//todo: I think this is not needed if it is reset elsewhere
        }
        positionRef.current.position = {
          left: positionRef.current.position.left + leftIncrement,
          center: positionRef.current.position.center + centerIncrement,
          right: positionRef.current.position.right + rightIncrement
        };
        setCurrentPosition(() => positionRef.current.position);
      }
      // //todo: can we smooth out the scroll using css animation?
      if (spinningRef.current && loopGuardRef.current < loopMax) {
        loopGuardRef.current += 1;
        //console.log('recursive loop call: ', requestRef.current);
        requestRef.current = window.requestAnimationFrame(loop);
        //console.log('recursive loop call after', requestRef.current);
      } else {
        callback();//tell caller we are done, can this be async?
      }
    };
    if (flipped.current === undefined && betSwitch !== undefined) {
      //console.log('flipped init state not triggering');
      flipped.current = !betSwitch;//to trigger on page load, reverse the boolean
    }
    //console.log('flipping test: ', flipped.current, betSwitch);
    if (flipped.current === betSwitch) {
      flipped.current = !betSwitch;//do not use: flipped.current = !flipped.current;//dangerous, because other values can cause even number of renders

      //idea: use css scroll stop position and allow the user to see all the items on a wheel
      const resetTimePassed = { left: false, center: false, right: false };
      const resetWheelsDeltaRef = { last: 0, change: 0, timePassed: resetTimePassed };
      wheelsDeltaRef.current = resetWheelsDeltaRef;
      //const comparisonPosition = {left: positionRef.current.position.left % 11, center: positionRef.current.position.center % 11, right: positionRef.current.position.right % 11};
      //console.log("current: ", comparisonPosition, positionRef.current.position, targetPosition);
      positionRef.current.next = targetPosition;
      setSpinCounter(previous => previous + 1);//todo: what happens when overflow occurs? max float + 1?
      spinningRef.current = true;//note, the reason this works is because spinCounter triggers a render, and at that time the ref is evaluated.
      //if the only thing changing is the ref, then the render will not trigger, and the toggle logic will fail.
      requestRef.current = window.requestAnimationFrame(loop);
    }

    return () => {
      //console.log('dispose rotate wheel set?', requestRef.current);
      //todo: why are there 2 dispose calls for the initial spin?
      loopGuardRef.current = 0;
      //waitForWheelStop.current = {left: false, center: false, right: false};
      //stop the animation when disposed?
      //if (cancelAnimationFrameId) window.cancelAnimationFrame(cancelAnimationFrameId);
    };
  }, [betSwitch, callback, targetPosition]);//todo: maybe instead of betSwitch, targetPosition could be used? 
  //Nope, because it is possible to get the same spin twice in a row and we need the spin to trigger
  const debugOutput = (
    <>
      <button onClick={cancelSpin} disabled={!spinningRef.current}>break</button><br />
      {`count: ${spinCounter} ${spinningRef.current ? "spinning" : "stopped"} ${timer} `}<br />
      {`time to settle: ${settleRef.current[0]}, ${settleRef.current[1]}, ${settleRef.current[2]}`}<br />
      <FramesPerSecond time={deltaTime.current} animationId={spinCounter} /><br />
    </>
  );

  return (
    <div>
      {props.debug ? debugOutput : null}
      <DisplayWheelSet startPosition={currentPosition} debug={props.debug} win={props.win} />
    </div>
  );
}

export default memo(RotateWheelSet);
