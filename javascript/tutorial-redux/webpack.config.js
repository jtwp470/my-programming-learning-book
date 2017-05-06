const path = require('path');

module.exports = {
    entry: {
        app: './index.js',
    },
    output: {
        path: path.resolve(__dirname, './dist'),
        filename: "[name].bundle.js",
    },
    module: {
        rules: [
            {
                test: /\.jsx?$/,
                exclude: /node_modules/,
                use: [{ loader: 'babel-loader' }]
            },
        ],
    },
    resolve: {
        extensions: ['*', '.js', '.jsx'],
    },
};