const path = require("path");
const glob = require("glob");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const TerserPlugin = require("terser-webpack-plugin");
const OptimizeCSSAssetsPlugin = require("optimize-css-assets-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const PurgecssPlugin = require("purgecss-webpack-plugin");
const globAll = require("glob-all");

module.exports = (env, options) => ({
  optimization: {
    minimizer: [
      new TerserPlugin(),
      new OptimizeCSSAssetsPlugin({}),
      new PurgecssPlugin({
        paths: globAll.sync([
          "../lib/app_web/templates/**/*.html.eex",
          "../lib/app_web/templates/**/*.html.leex",
          "../lib/app_web/views/**/*.ex",
          "../assets/js/**/*.js"
        ]),
        extractors: [
          {
            extractor: content => content.match(/[\w-/:]+(?<!:)/g) || [],
            extensions: ["html", "js", "eex", "ex"]
          }
        ]
      })
    ]
  },
  entry: {
    "./js/app.js": ["./js/app.js"].concat(glob.sync("./vendor/**/*.js"))
  },
  output: {
    filename: "app.js",
    path: path.resolve(__dirname, "../priv/static/js")
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader"
        }
      },
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, "css-loader", "postcss-loader"]
      }
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: "../css/app.css" }),
    new CopyWebpackPlugin([{ from: "static/", to: "../" }])
  ]
});
