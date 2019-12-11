import React from 'react';

const Bell = props => {
  const animationClass = props.win ? "animated-bell" : "";
  return (
    <div>
      <svg viewBox="0.5 0 30 30" width="90px" height="90px" xmlns="http://www.w3.org/2000/svg" xmlnsXlink="http://www.w3.org/1999/xlink">
        <defs>
          <symbol id="symbol-bell" viewBox="0.5 0 30 30">
            <g>
              <path d="M 0,0 V 30 H 30 V 0z" className="bell-background" />
              <path d="M 4 22 V 25" className="bell1" />
              <path d="M 5 21 V 25" className="bell2" />
              <path d="M 6 18 V 25" className="bell3" />
              <path d="M 7 13 V 25" className="bell4" />
              <path d="M 8 10 V 25" className="bell5" />
              <path d="M 9 8 V 25" className="bell6" />
              <path d="M 10 7 V 25" className="bell7" />
              <path d="M 10 7 V 25" className="bell8" />
              <path d="M 11 7 V 25" className="bell9" />
              <path d="M 12 6 V 25" className="bell10" />
              <path d="M 13 6 V 26 M 13 4 V 5" className="bell11" />
              <path d="M 14 3 V 27" className="bell12" />
              <path d="M 15 2 V 28" className="bell13" />
              <path d="M 16 2 V 28" className="bell14" />
              <path d="M 17 3 V 27" className="bell15" />
              <path d="M 18 6 V 26 M 18 4 V 5" className="bell16" />
              <path d="M 19 6 V 25" className="bell17" />
              <path d="M 20 7 V 25" className="bell18" />
              <path d="M 21 7 V 25" className="bell19" />
              <path d="M 22 8 V 25" className="bell20" />
              <path d="M 23 10 V 25" className="bell21" />
              <path d="M 24 13 V 25" className="bell22" />
              <path d="M 25 18 V 25" className="bell23" />
              <path d="M 26 21 V 25" className="bell24" />
              <path d="M 27 22 V 25" className="bell25" />
            </g>
          </symbol>
        </defs>
        <title>bell symbol instance</title>
        <desc>Update of bell pixel graphics to modern SVG. Contains a bell graphic with lines drawn vertically down.</desc>
        <style>
          {`
                    .bell-background {stroke: #000000; paint-order: stroke;}
                    .bell1 {stroke: #0008fc;}
                    .bell2 {stroke: #0010fc;}
                    .bell3 {stroke: #0018fc;}
                    .bell4 {stroke: #0020fc;}
                    .bell5 {stroke: #0028fc;}
                    .bell6 {stroke: #0030fc;}
                    .bell7 {stroke: #0038fc;}
                    .bell8 {stroke: #0040fc;}
                    .bell9 {stroke: #0048fc;}
                    .bell10 {stroke: #0050fc;}
                    .bell11 {stroke: #0058fc;}
                    .bell12 {stroke: #0060fc;}
                    .bell13 {stroke: #0068fc;}
                    .bell14 {stroke: #0070fc;}
                    .bell15 {stroke: #0078fc;}
                    .bell16 {stroke: #0080fc;}
                    .bell17 {stroke: #0088fc;}
                    .bell18 {stroke: #0090fc;}
                    .bell19 {stroke: #0098fc;}
                    .bell20 {stroke: #00a0fc;}
                    .bell21 {stroke: #00a8fc;}
                    .bell22 {stroke: #00b0fc;}
                    .bell23 {stroke: #00b8fc;}
                    .bell24 {stroke: #00c0fc;}
                    .bell25 {stroke: #00c8fc;}
                    @keyframes winner {
                        from {fill: rgb(0,0,0);}
                        to {fill: gold;}
                    }
                    .animated-bell {
                        animation-name: winner;
                        animation-delay: 3s;
                        animation-duration: 4s;
                        animation-iteration-count: 3;
                        animation-fill-mode: forwards;
                    }
                `}
        </style>
        <use className={animationClass} width="30" height="30" transform="matrix(1, 0, 0, 1, 0, 0)" xlinkHref="#symbol-bell" />
      </svg>
    </div>
  );
}

export default Bell;
