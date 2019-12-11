import React, { useRef, memo } from 'react';

const FramesPerSecond = (props) => {
  const render = useRef(0);
  const initFrameRateRef = { last: 0, high: 60, low: 60, error: "", framesPerSecond: 60 };
  const frameRateRef = useRef(initFrameRateRef);
  const animationId = useRef(props.animationId);
  const animationStarted = useRef(false);
  if (animationStarted.current) {
    animationStarted.current = false;
    //new animation to calculate when the time next changes
    //console.log("spin pressed and time changed, animationId: " + props.animationId + ", " + animationId.current + ", " + render.current);
    frameRateRef.current = initFrameRateRef;
  }
  if (props.animationId !== animationId.current) {
    //new animation to calculate when the time next changes
    animationStarted.current = true;
    //console.log("animationId: " + props.animationId + ", " + animationId.current + ", " + render.current);
    frameRateRef.current = initFrameRateRef;
    animationId.current = props.animationId;
  }
  if (frameRateRef.current.last === 0) {
    //first iteration, the change should be 1000/60
    //console.log("first animation: " + animationId.current + ", adjusted time: " + (props.time - 16.6));
    frameRateRef.current.last = props.time - 16.6;//1000/60 ~= 16.6
  }
  const currentFramesPerSecond = Math.floor(1000 / (props.time - frameRateRef.current.last));
  const before = { time: props.time, last: frameRateRef.current.last, renderCurrent: render.current };
  //console.log("before time: " + before.time + ", last: " + before.last + ", fps: " + currentFramesPerSecond + ", delta: " + (before.time - before.last) + ", render: " + before.renderCurrent);
  if (currentFramesPerSecond !== frameRateRef.current.framesPerSecond) {
    if (currentFramesPerSecond > frameRateRef.current.high && isFinite(currentFramesPerSecond)) {
      frameRateRef.current.high = currentFramesPerSecond;
    }
    if (currentFramesPerSecond < frameRateRef.current.low) {
      frameRateRef.current.low = currentFramesPerSecond;
    }
    if (isNaN(currentFramesPerSecond)) {
      frameRateRef.current.error += "NaN found";
    }
    if (!isFinite(currentFramesPerSecond)) {
      frameRateRef.current.error += "Divide by zero time found. time: " + before.time + ", last: " + before.last + ", render: " + before.renderCurrent;
    }
    if (currentFramesPerSecond === 0) {
      frameRateRef.current.error += "no frames per second? time: " + before.time + " last: " + before.last + " render: " + before.renderCurrent;
    }
    frameRateRef.current.framesPerSecond = currentFramesPerSecond;// * frameCount (i.e. * 1)
  }
  frameRateRef.current.last = props.time;

  return (
    <>
      Render: {render.current++} FPS: {frameRateRef.current.framesPerSecond} ({frameRateRef.current.low}-{frameRateRef.current.high}) {frameRateRef.current.error}
    </>
  );
}

export default memo(FramesPerSecond);
