import React from 'react';

const Cherry = props => {
  const animationClass = props.win ? "animated-cherry" : "";
  const canary = "#ffff8c";
  return (
    <div>
      <svg viewBox="0.5 0 30 30" width="90px" height="90px" xmlns="http://www.w3.org/2000/svg" xmlnsXlink="http://www.w3.org/1999/xlink">
        <defs>
          <symbol id="symbol-cherry" viewBox="0.5 0 30 30">
            <g>
              <path d="M 0.5,-0.5 V 30.5 H 31 V -0.5z" className="cherry-background" />
              <path d="M 4,20 V 26 M 19,20 V 26" className="cherry4" />
              <path d="M 5,19 V 27 M 20,19 V 27" className="cherry5" />
              <path d="M 6,18 V 28 M 21,18 V 28" className="cherry6" />
              <path d="M 7,18 V 28 M 22,21 V 28" className="cherry7" />
              <path d="M 8,18 V 28 M 23,21 V 28" className="cherry8" />
              <path d="M 9,18 V 21 M 9,22 V 28 M 24,18 V 28" className="cherry9" />
              <path d="M 10,18 V 20 M 10,22 V 28 M 25,18 V 28" className="cherry10" />
              <path d="M 11,21 V 27 M 26,19 V 27" className="cherry11" />
              <path d="M 12,20 V 26 M 27,20 V 26" className="cherry12" />
              <path d="M 9,20 V 23" className="cherry-stem9" />
              <path d="M 10,19 V 23" className="cherry-stem10" />
              <path d="M 11,17 V 22" className="cherry-stem11" />
              <path d="M 12,16 V 20" className="cherry-stem12" />
              <path d="M 13,14 V 19" className="cherry-stem13" />
              <path d="M 14,12 V 17" className="cherry-stem14" />
              <path d="M 15,10 V 15" className="cherry-stem15" />
              <path d="M 16,7 V 13" className="cherry-stem16" />
              <path d="M 17,6 V 11" className="cherry-stem17" />
              <path d="M 18,5 V 9" className="cherry-stem18" />
              <path d="M 19,5 V 8" className="cherry-stem19" />
              <path d="M 20,4 V 12" className="cherry-stem20" />
              <path d="M 21,3 V 17" className="cherry-stem21" />
              <path d="M 22,11 V 22" className="cherry-stem22" />
              <path d="M 23,16 V 22" className="cherry-stem23" />
            </g>
          </symbol>
        </defs>
        <title>cherry symbol instance</title>
        <desc>Update of cherry pixel graphics to modern SVG. Contains a cherry graphic with lines drawn vertically down.</desc>
        <style>{`
            .cherry-background {stroke: #000000; paint-order: stroke;}
            .cherry4 {stroke: #fc0000;}
            .cherry5 {stroke: #fc1414;}
            .cherry6 {stroke: #fc2828;}
            .cherry7 {stroke: #fc3c3c;}
            .cherry8 {stroke: #fc5050;}
            .cherry9 {stroke: #fc6464;}
            .cherry10 {stroke: #fc7878;}
            .cherry11 {stroke: #fc8c8c;}
            .cherry12 {stroke: #fca0a0;}
            .cherry-stem9 {stroke: #3cfc3c;}
            .cherry-stem10 {stroke: #44fc40;}
            .cherry-stem11 {stroke: #4cfc44;}
            .cherry-stem12 {stroke: #54fc48;}
            .cherry-stem13 {stroke: #5cfc4c;}
            .cherry-stem14 {stroke: #64fc50;}
            .cherry-stem15 {stroke: #6cfc54;}
            .cherry-stem16 {stroke: #74fc58;}
            .cherry-stem17 {stroke: #7cfc5c;}
            .cherry-stem18 {stroke: #84fc60;}
            .cherry-stem19 {stroke: #8cfc64;}
            .cherry-stem20 {stroke: #94fc68;}
            .cherry-stem21 {stroke: #9cfc6c;}
            .cherry-stem22 {stroke: #a4fc70;}
            .cherry-stem23 {stroke: #acfc74;}
            @keyframes winner-cherry {
              0% {fill: rgb(0,0,0);}
              50% {fill: gold;}
              100% {fill: ${canary};}
            }
            .animated-cherry {
              animation-name: winner-cherry;
              animation-delay: 1.2s;
              animation-duration: 0.25s;
              animation-iteration-count: 1;
              animation-fill-mode: forwards;
            }
          `}
        </style>
        <use className={animationClass} width="30" height="30" transform="matrix(1, 0, 0, 1, 0, 0)" xlinkHref="#symbol-cherry" >
          <animateTransform attributeName="transform" type="scale" additive="sum" from="1 1" to="1 0.9" begin="0" dur="0.1s" />
          <animateTransform attributeName="transform" type="scale" additive="sum" from="1 0.9" to="1 1" begin="0.1s" dur="0.1s" />
        </use>
      </svg>
    </div>
  );
}

export default Cherry;
