[![Build Status](https://travis-ci.org/coingecko/cryptoexchange.svg)](https://travis-ci.org/coingecko/cryptoexchange)

# Cryptoexchange

Cryptoexchange is a rubygem for ruby developers to interact with multiple cryptocurrency exchange market data APIs in a single library.

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
| ANX               | Y       |            |         |         | User-Defined|
| Gatecoin          | Y       |            |         |         | Y           |
| Bitso             | Y       |            |         |         | Y           |
| BTCC              | Y       |            |         |         | User-Defined|
| OKCoin            | Y       |            |         |         | User-Defined|
| LakeBTC           | Y       |            |         |         | Y           |
| Huobi             | Y       |            |         |         | Y           |
| Yunbi             | Y       |            |         |         | Y           |
| Yuanbao           | Y       |            |         |         | User-Defined|
| BTC38             |         |            |         |         |             |
| CHBTC             | Y       |            |         |         | User-Defined|
| Bitstamp          | Y       |            |         |         | User-Defined|
| Bittrex           | Y       |            |         |         | Y           |
| GDAX              | Y       |            |         |         | Y           |
| Gemini            | Y       |            |         |         | Y           |
| Poloniex          | Y       |            |         |         | Y           |
| Kraken            | Y       |            |         |         | Y           |
| Coincheck         | Y       |            |         |         | User-Defined|
| Bitflyer          | Y       |            |         |         | Y           |
| Quoine            | Y       |            |         |         | Y           |
| QuadrigaCX        | Y       |            |         |         | User-Defined|
| Unocoin           |         |            |         |         |             |
| Coinone           | Y       |            |         |         | Y           |
| Korbit            | Y       |            |         |         | User-Defined|
| Bithumb           | Y       |            |         |         | User-Defined|
| Luno              |         |            |         |         |             |
| BTC-e             |         |            |         |         |             |
| Bleutrade         | Y       |            |         |         | Y           |
| Yobit             | Y       |            |         |         | Y           |
| Bitfinex          | Y       |            |         |         | Y           |
| BTER              | Y       |            |         |         | Y           |
| Cryptopia         | Y       |            |         |         | Y           |
| Livecoin          | Y       |            |         |         | Y           |
| Nova Exchange     | Y       |            |         |         | Y           |
| Bitcoin Indonesia | Y       |            |         |         | User-Defined|
| Liqui             | Y       |            |         |         | Y           |
| HitBTC            | Y       |            |         |         | Y           |
| CCex              | Y       |            |         |         | Y           |
| CoinExchange      | Y       |            |         |         | Y           |
| EtherDelta        | Y       |            |         |         | Y           |
| Bitbay            |         |            |         |         |             |
| Bitso             |         |            |         |         |             |
| BTCChina          |         |            |         |         |             |
| Coinmate          |         |            |         |         |             |
| Itbit             |         |            |         |         |             |
| Jubi              | Y       |            |         |         | Y           |
| MercadoBitcoin    | Y       |            |         |         | User-Defined|
| Viabtc            | Y       |            |         |         | User-Defined|
| Tidex             | Y       |            |         |         | Y           |
| Bitbay            | Y       |            |         |         | User-Defined|
| SZZC              | Y       |            |         |         | Y           |
| BX Thailand       | Y       |            |         |         | Y           |

## Usage

### List market pairs supported by an exchange
```
  client = Cryptoexchange::Client.new
  pairs = client.pairs('bitflyer')
```

### Query the Ticker API
```
  pair = client.pairs('bitflyer').first
  ticker = client.ticker(pairs.last)
  ticker.base
  ticker.target
  ticker.last
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

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cryptoexchange. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
