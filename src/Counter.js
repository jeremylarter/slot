import React, { useEffect, useRef, useState } from 'react';
//an animation method to critique from: https://codepen.io/HunorMarton/pen/EqmyMN , https://css-tricks.com/using-requestanimationframe-with-react-hooks/
const Counter = () => {
  const [count, setCount] = useState(0)

  // Use useRef for mutable variables that we want to persist
  // without triggering a re-render on their change
  const requestRef = useRef();
  const previousTimeRef = useRef();

  const animate = time => {
    if (previousTimeRef.current !== undefined) {
      const deltaTime = time - previousTimeRef.current;

      // Pass on a function to the setter of the state
      // to make sure we always have the latest state
      setCount(prevCount => (prevCount + deltaTime * 0.01) % 100);
      console.log('animate: ', count);
    }
    previousTimeRef.current = time;
    requestRef.current = requestAnimationFrame(animate);
  }

  useEffect(() => {
    requestRef.current = requestAnimationFrame(animate);
    return () => cancelAnimationFrame(requestRef.current);
  }, []); // Make sure the effect runs only once

  return <div>{Math.round(count)}</div>
}

export default Counter;
