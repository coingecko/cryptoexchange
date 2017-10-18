[![Build Status](https://travis-ci.org/coingecko/cryptoexchange.svg)](https://travis-ci.org/coingecko/cryptoexchange)

# Cryptoexchange

Cryptoexchange is a rubygem for ruby developers to interact with over 40+ cryptocurrency exchange market data APIs in a single library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cryptoexchange'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cryptoexchange

## Exchanges Supported

| Exchange          | Ticker  | Order Book | Trade   | Account | Market List |
| ----------------- | ------- | ---------- | ------- | ------- | ----------- |
| Allcoin           | Y       |  Y         |         |         | User-Defined|
| ANX               | Y       |            |         |         | User-Defined|
| Bit-Z             | Y       |            |         |         | Y
| Binance           |         |            |         |         |             |
| Bitbay            | Y       |            |         |         | User-Defined|
| Bitcoin Indonesia | Y       |            |         |         | User-Defined|
| Bitfinex          | Y       |            |         |         | Y           |
| Bitflyer          | Y       |            |         |         | Y           |
| Bithumb           | Y       |            |         |         | Y           |
| Bitkonan          | Y       |            |         |         | User-Defined|
| Bitso             | Y       |            |         |         | Y           |
| Bitstamp          | Y       |            |         |         | User-Defined|
| Bittrex           | Y       |            |         |         | Y           |
| Bleutrade         | Y       |            |         |         | Y           |
| BTC-e             |         |            |         |         |             |
| BTC38             |         |            |         |         |             |
| BTCC              | Y       |            |         |         | User-Defined|
| BTCChina          |         |            |         |         |             |
| BTER              | Y       |            |         |         | Y           |
| BX Thailand       | Y       |            |         |         | Y           |
| CCex              | Y       |            |         |         | Y           |
| CHBTC             | Y       |            |         |         | User-Defined|
| Coincheck         | Y       |            |         |         | User-Defined|
| CoinExchange      | Y       |            |         |         | Y           |
| Coinmate          | Y       | Y          |         |         | User-Defined|
| Coinone           | Y       |            |         |         | Y           |
| Cryptopia         | Y       |            |         |         | Y           |
| EtherDelta        | Y       |            |         |         | Y           |
| Gatecoin          | Y       |            |         |         | Y           |
| GDAX              | Y       |            |         |         | Y           |
| Gemini            | Y       | Y          | Y       |         | Y           |
| HitBTC            | Y       |            |         |         | Y           |
| Huobi             | Y       |            |         |         | Y           |
| Itbit             | Y       |            |         |         | User-Defined|
| Jubi              | Y       |            |         |         | Y           |
| Korbit            | Y       |            |         |         | User-Defined|
| Kraken            | Y       |            |         |         | Y           |
| LakeBTC           | Y       |            |         |         | Y           |
| Liqui             | Y       |            |         |         | Y           |
| LiteBit.eu        | Y       |            |         |         | Y           |
| Livecoin          | Y       |            |         |         | Y           |
| Luno              | Y       |            |         |         | Y           |
| MercadoBitcoin    | Y       |            |         |         | User-Defined|
| Nova Exchange     | Y       |            |         |         | Y           |
| OKCoin            | Y       |            |         |         | User-Defined|
| Poloniex          | Y       |            |         |         | Y           |
| Qryptos           | Y       |            |         |         | Y           |
| QuadrigaCX        | Y       |            |         |         | User-Defined|
| Quoine            | Y       |            |         |         | Y           |
| SZZC              | Y       |            |         |         | Y           |
| The Rock Trading  | Y       |            |         |         | Y           |
| Tidex             | Y       |            |         |         | Y           |
| TuxExchange       | Y       |            |         |         | Y           |
| Unocoin           |         |            |         |         |             |
| Viabtc            | Y       |            |         |         | User-Defined|
| Yobit             | Y       |            |         |         | Y           |
| Yuanbao           | Y       |            |         |         | User-Defined|
| Yunbi             | Y       |            |         |         | Y           |

## Usage

### List market pairs supported by an exchange
```
  client = Cryptoexchange::Client.new
  pairs = client.pairs('bitflyer')
```

### List exchange services for certain currency
```
  client.exchange_for('btc')

  # ['anx', 'bianance', ...]
```

### Query the Ticker API
```
  pair = client.pairs('bitflyer').first
  ticker = client.ticker(pairs.last)
  ticker.base
  ticker.target
  ticker.last
```

### Query the OrderBook API
```
  # Check if exchange has support for OrderBook
  pair = client.pairs('bitflyer').first
  order_book = client.order_book(pairs.last)
  order_book.base
  order_book.target
  order_book.bids
  order_book.asks
```

### Market List
Some exchange API do not support market pair listings. For those exchanges, we included
a custom YML file to define the list of market pairs supported by that exchange.
That configuration works out of the box, however if that exchange adds new market pairs,
you as the user of Cryptoexchange can explicitly add those pairs instead of waiting
for this library to be updated.

In the table above, look for the `User-Defined` under the Market List column.

The format of the yaml file should look like below.
Name the file <exchange_name>.yml and place it under the config/cryptoexchange directory.
```
  :pairs:
    - :base: BTC
      :target: KRW
    - :base: ETH
      :target: KRW
    - :base: ETC
      :target: KRW
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/coingecko/cryptoexchange. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

When implementing a new exchange, refer to this [guide](https://github.com/coingecko/cryptoexchange/wiki/Implementing-a-New-Exchange).

The [contributing guide](https://github.com/coingecko/cryptoexchange/blob/master/CONTRIBUTING.md) may also be useful to you.

You can chat with the core team member or other participating in this repository chat on [https://gitter.im/cryptoexchange-api/Lobby/~chat#](https://gitter.im/cryptoexchange-api/Lobby/~chat#)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
