const path = require('path');

module.exports = {
    entry: {
        app: "./index.ts",
    },
    output: {
        path: path.resolve(__dirname, "./dist"),
        filename: "[name].bundle.js",
    },
    resolve: {
        extensions: ["*", ".ts", ".tsx", ".js", ".jsx"],
    },
    module: {
        rules: [
            {
                test: /.tsx?$/,
                use: [{ loader: "ts-loader" }],
            },
        ],
    },
};