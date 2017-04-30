import * as React from "react";
import * as ReactDom from "react-dom";
import TodoApp from "./todoapp";

ReactDom.render(
    React.createElement(TodoApp),
    document.getElementById("app")
);