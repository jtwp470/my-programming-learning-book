const path = require("path");

const config = {
    entry: {
        app: "./src/view/index.tsx",
    },
    output: {
        filename: "[name]-bundle.js",
        path: path.resolve(__dirname, "./dist/public/javascripts"),
    },
    resolve: {
        extensions: [".ts", ".tsx", ".js", ".jsx"],
    },
    module: {
        rules: [
            {
                test: /\.tsx?$/,
                use: {
                    loader: "ts-loader",
                },
            }
        ],
    },
};

module.exports = config;