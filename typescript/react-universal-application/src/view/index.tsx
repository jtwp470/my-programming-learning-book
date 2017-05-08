import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { BrowserRouter } from 'react-router-dom';
import Application from './Application';

ReactDOM.render(
    <BrowserRouter>
        <Application/>
    </BrowserRouter>,
    document.getElementById("react-root")
);