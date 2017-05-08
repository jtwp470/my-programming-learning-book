import * as Koa from 'koa';
import * as path from 'path';
import * as staticFiles from 'koa-static';
import * as React from 'react';
import * as ReactDOM from 'react-dom/server';
import { StaticRouter } from 'react-router';
import { Helmet } from 'react-helmet';
import Application from '../view/Application';

const app = new Koa();

app.use(staticFiles(path.resolve(__dirname, "../public")));

app.use(ctx => {
    const context: { url?: string, status?:string } = {};
    const markup = ReactDOM.renderToString(
        <StaticRouter location={ctx.url} context={context}>
            <Application/>
        </StaticRouter>
    );
    // https://github.com/nfl/react-helmet#server-usage
    const helmet = Helmet.renderStatic();
    
    if (context.url) {
        ctx.redirect(context.url);
    } else {
        ctx.body = `
            <!DOCTYPE html>
            <html ${helmet.htmlAttributes.toString()}>
                <head>
                    ${helmet.title.toString()}
                </head>
                <body>
                    <div id="react-root">
                    ${markup}
                    </div>
                    <script type="text/javascript" src="/javascripts/app-bundle.js"></script>
                </body>
            </html>
        `
    }
});

app.listen(process.env.PORT || 3000);