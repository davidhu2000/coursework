module.exports = {
  context: __dirname,
  entry: './widgets.jsx',
  output: {
    path: './',
    filename: 'bundle.js'
  },
  devtool: 'source-map',
  module: {
    loaders: [{
      test: [/\.jsx?$/, /\.js?$/],
      exclude: /node_modules/,
      loader: 'babel',
      query: {
        presets: ['react', 'es2015']
      }
    }]
  },
  resolve: {
    extensions: ['', '.js', '.jsx']
  }
};
