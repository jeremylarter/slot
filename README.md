# Slot Machine Simulator

This is a port of an assignment from 1992. The original code was written in [Microsoft QuickPascal](https://en.wikipedia.org/wiki/Microsoft_Pascal). The original documentation was done in some editor that I cannot recall. Any modern editor should be able to get the text content from the doc files included. For those interested in getting the screen shots, the doc format is most likely an early version of [Works for MS-DOS](https://en.wikipedia.org/wiki/Microsoft_Works#Works_for_MS-DOS). Other editors I used back in the day were [MS-DOS Editor](https://en.wikipedia.org/wiki/MS-DOS_Editor) and [edlin](https://en.wikipedia.org/wiki/Edlin).

## Purpose of port?

It was one of my favorite assignments that showcased [VGA graphics](https://en.wikipedia.org/wiki/Mode_13h). The screen resolution was just 320x200 (like an Apple watch but on a full size monitor). The draw for me was that it could display 256 colours from a palette of about 65,000.

Today I am interested in React, SVG, CSS animation, Azure cloud hosting and accessibility. So doing a port allows me to explore these areas of interest in a well defined scope. I created the original graphics, so I do not have to worry about copyright or creating new art.

For the image conversion to [SVG][], I have kept the original blockiness. This style has had a resurgence due to games like Minecraft <sup>[(1)](#disclaimer)</sup> and various spin off titles.

[svg]: https://en.wikipedia.org/wiki/Scalable_Vector_Graphics "Scaleable Vector Graphics"

<a name="disclaimer"></a><sup>(1)</sup> [NOT AN OFFICIAL MINECRAFT PRODUCT. NOT APPROVED BY OR ASSOCIATED WITH MOJANG](https://account.mojang.com/terms?ref=ft#brand).

## Simulation specifications

The machine parameters were given to me as part of the assignment and I implemented them "as is." The result is a slot machine that pays out about 150%, so it is not a realistic simulation. Rather, it is just an academic exercise. Doing this assignment taught me that real world machines will take your money because they pay out less than 100%.

## Port technology

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.<br />
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.<br />
You will also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.<br />
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.<br />
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.<br />
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can’t go back!**

If you aren’t satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (Webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you’re on your own.

You don’t have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn’t feel obligated to use this feature. However we understand that this tool wouldn’t be useful if you couldn’t customize it when you are ready for it.

## Learn More

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

### Code Splitting

This section has moved here: https://facebook.github.io/create-react-app/docs/code-splitting

### Analyzing the Bundle Size

This section has moved here: https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size

### Making a Progressive Web App

This section has moved here: https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app

### Advanced Configuration

This section has moved here: https://facebook.github.io/create-react-app/docs/advanced-configuration

### Deployment

This section has moved here: https://facebook.github.io/create-react-app/docs/deployment

### `npm run build` fails to minify

This section has moved here: https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify
