var Encore = require('@symfony/webpack-encore');
const HtmlWebpackPlugin = require('html-webpack-plugin');

Encore
    // directory where compiled assets will be stored
    .setOutputPath('dist/')
    // public path used by the web server to access the output path
    .setPublicPath('/')

    /*
     * ENTRY CONFIG
     *
     * Add 1 entry for each "page" of your app
     * (including one that's included on every page - e.g. "app")
     *
     * Each entry will result in one JavaScript file (e.g. app.js)
     * and one CSS file (e.g. app.css) if your JavaScript imports CSS.
     */
    .addEntry('app', './src/app.js')
    //.enableSingleRuntimeChunk()
    .disableSingleRuntimeChunk()

    .cleanupOutputBeforeBuild()
    .enableSourceMaps(!Encore.isProduction())
    // enables hashed filenames (e.g. app.abc123.css)
    .enableVersioning(Encore.isProduction())

    // uncomment if you use TypeScript
    //.enableTypeScriptLoader()
    // uncomment if you use Sass/SCSS files
    //.enableSassLoader()

    // uncomment if you're having problems with a jQuery plugin
    .autoProvidejQuery()

    // .cleanupOutputBeforeBuild()
    .addPlugin(
      new HtmlWebpackPlugin({
        "hash": Encore.isProduction(),
        "template": "./src/index.html",
        "minify": Encore.isProduction(),
        "chunksSortMode": "auto"
      })
    )
;

module.exports = Encore.getWebpackConfig();
// console.log(module.exports);
