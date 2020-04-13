import React from 'react';

const Bar = ({ mykey, ...props }) => {
  //if (props.win) console.log(`animated-bar${mykey}`);
  const className = props.win ? `animated-bar${mykey}` : "bar-background";
  const symbolId = mykey === undefined ? "bar-symbol" : mykey;
  //console.log({ className });
  return (
    <div>
      <svg viewBox="0.5 0 30 30" width="90px" height="90px" xmlns="http://www.w3.org/2000/svg" xmlnsXlink="http://www.w3.org/1999/xlink">
        <defs>
          <symbol id={symbolId} viewBox="0.5 0 30 30">
            <g>
              <path d="M 0,0 V 30 H 30 V 0z" className={className} />
              <path d="M 2,7 V 24" className="bar2" />
              <path d="M 3,7 V 24" className="bar3" />
              <path d="M 4,7 V 10 M 4,14 V 17 M 4,21 V 24" className="bar4" />
              <path d="M 5,7 V 10 M 5,14 V 17 M 5,21 V 24" className="bar5" />
              <path d="M 6,7 V 11 M 6,13 V 18 M 6,20 V 24" className="bar6" />
              <path d="M 7,8 V 12 M 7,12 V 19 M 7,19 V 23" className="bar7" />
              <path d="M 8,9 V 15 M 8,16 V 23" className="bar8" />
              <path d="M 9,10 V 14 M 9,17 V 21" className="bar9" />
              <path d="M 12,17 V 24" className="bar12" />
              <path d="M 13,12 V 24" className="bar13" />
              <path d="M 14,9 V 21" className="bar14" />
              <path d="M 15,7 V 15 M 15,17 V 20" className="bar15" />
              <path d="M 16,7 V 15 M 16,17 V 20" className="bar16" />
              <path d="M 17,9 V 21" className="bar17" />
              <path d="M 18,12 V 24" className="bar18" />
              <path d="M 19,17 V 24" className="bar19" />
              <path d="M 22,7 V 24" className="bar22" />
              <path d="M 23,7 V 24" className="bar23" />
              <path d="M 24,7 V 10 M 24,14 V 17" className="bar24" />
              <path d="M 25,7 V 10 M 25,14 V 18" className="bar25" />
              <path d="M 26,7 V 11 M 26,13 V 20" className="bar26" />
              <path d="M 27,8 V 12 M 27,12 V 16 M 27,16 V 22" className="bar27" />
              <path d="M 28,9 V 15 M 28,18 V 24" className="bar28" />
              <path d="M 29,10 V 14 M 29,20 V 24" className="bar29" />
            </g>
          </symbol>
        </defs>
        <title>bar symbol instance</title>
        <desc>Update of bar pixel graphics to modern SVG. Contains a bar graphic with lines drawn vertically down.</desc>
        <style>{`
                    .bar-background {stroke: white; paint-order: stroke; fill: rgb(255, 255, 255)}
                    .bar2 {stroke: #0808fc;}
                    .bar3 {stroke: #1010fc;}
                    .bar4 {stroke: #1818fc;}
                    .bar5 {stroke: #2020fc;}
                    .bar6 {stroke: #2828fc;}
                    .bar7 {stroke: #3030fc;}
                    .bar8 {stroke: #3838fc;}
                    .bar9 {stroke: #4040fc;}
                    .bar12 {stroke: #4848fc;}
                    .bar13 {stroke: #5050fc;}
                    .bar14 {stroke: #5858fc;}
                    .bar15 {stroke: #6060fc;}
                    .bar16 {stroke: #6868fc;}
                    .bar17 {stroke: #7070fc;}
                    .bar18 {stroke: #7878fc;}
                    .bar19 {stroke: #8080fc;}
                    .bar22 {stroke: #8888fc;}
                    .bar23 {stroke: #9090fc;}
                    .bar24 {stroke: #9898fc;}
                    .bar25 {stroke: #a0a0fc;}
                    .bar26 {stroke: #a8a8fc;}
                    .bar27 {stroke: #b0b0fc;}
                    .bar28 {stroke: #b8b8fc;}
                    .bar29 {stroke: #c0c0fc;}
                    @keyframes winner${mykey} {
                        from {fill: rgb(255,255,255);}
                        to {fill: gold;}
                    }
                    .animated-bar${mykey} {
                        fill: rgb(255,255,255);
                        animation-name: winner${mykey};
                        animation-delay: 1.2s;
                        animation-duration: 0.25s;
                        animation-iteration-count: 1;
                        animation-fill-mode: forwards;
                    }
                `}
        </style>
        <use width="30" height="30" transform="matrix(1, 0, 0, 1, 0, 0)" xlinkHref={"#" + symbolId} />
      </svg>
    </div>
  );
}

export default Bar;
