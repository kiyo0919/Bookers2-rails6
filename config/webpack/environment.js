const { environment } = require('@rails/webpacker')

module.exports = environment

const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)

// ここの記述がカルキュラムと違う場合、非同期が行われないことがある。bootstrap導入の章で説明あり。
//エラーとしては検証ツールに Uncaught ReferenceError: $ is not definedが出て、jqueryが定義されていないとでる。