import * as React from 'react';
import { Switch, Route } from 'react-router';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet';

export default class Application extends React.Component<any, any> {
    render() {
        return (
            <div className="application">
                <Helmet
                    title="application"
                />

                <ul>
                    <li><Link to="/">root</Link></li>
                    <li><Link to="/users">user</Link></li>
                </ul>

                <Switch>
                    <Route exact path="/" component={() => { return <div>root page</div>; }} />
                    <Route path="/users" component={() => { return <div>user page</div>;  }} />
                    <Route component={() => { return <div>404 Not Found</div>; }} />
                </Switch>
            </div>
        );
    }
}