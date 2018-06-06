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

| Exchange          | Ticker | Order Book | Trade    | Account | Market List  |
| ----------------- | ------ | ---------- | -------- | ------- | ------------ |
| Abcc              | Y      | N          | N        |         | Y            |
| Abucoins          | Y      | Y          | Y        |         | Y            |
| ACX               | Y      | Y          | Y        |         | Y            |
| AEX               | Y      | Y          | Y        |         | Y            |
| Allcoin           | Y      | Y          |          |         | User-Defined |
| ANX               | Y      |            |          |         | User-Defined |
| Bancor            | Y      | N          | N        |         | Y            |
| Bcex              | Y      | Y          | Y        |         | Y            |
| Bibox             | Y      | Y          | Y        |         | Y            |
| BigONE            | Y      | Y          | Y        |         | Y            |
| Bit-Z             | Y      |            |          |         | Y            |
| Bit2C             | Y      | Y          | Y        |         | User-Defined |
| Binance           | Y      | Y          |          |         | Y            |
| Bitbay            | Y      |            |          |         | User-Defined |
| BitBNS            | Y      |            |          |         | Y            |
| Bitbank           | Y      | Y          | Y        |         | User-Defined |
| Bitcoin Indonesia | Y      |            |          |         | User-Defined |
| Bitconnect        | Y      |            |          |         | Y            |
| Bitebtc           | Y      | Y          | Y        |         | Y            |
| Bitfinex          | Y      |            |          |         | Y            |
| Bitflyer          | Y      |            |          |         | Y            |
| Bithash           | Y      | Y          | Y        |         | Y            |
| Bithumb           | Y      |            |          |         | Y            |
| Bitibu            | Y      | Y          | Y        |         | Y            |
| Bitkonan          | Y      |            |          |         | User-Defined |
| Bitmex            | Y      | Y          | Y        |         | Y            |
| Bitpaction        | Y      | Y          | Y        |         | Y            |
| Bits Blockchain   | Y      | Y          |          |         | Y            |
| Bitso             | Y      |            |          |         | Y            |
| Bitstamp          | Y      | Y          | Y        |         | User-Defined |
| Bittrex           | Y      |            |          |         | Y            |
| Bleutrade         | Y      |            |          |         | Y            |
| Braziliex         | Y      | Y          | Y        |         | Y            |
| BtcAlpha          | Y      | Y          | Y        |         | Y            |
| BtcTradeUa        | Y      | Y          | Y        |         | Y            |
| BTCBox            | Y      | Y          |          |         | User-Defined |
| BTC-e             |        |            |          |         |              |
| BTC38             |        |            |          |         |              |
| BTCC              | Y      |            |          |         | User-Defined |
| BTCChina          |        |            |          |         |              |
| Btcsquare         | Y      | Y          | Unstable |         | Y            |
| BTER              | Y      |            |          |         | Y            |
| Buyucoin          | Y      | N          | N        |         | Y            |
| BX Thailand       | Y      |            |          |         | Y            |
| Cex               | Y      | Y          | Y        |         | Y            |
| CCex              | Y      |            |          |         | Y            |
| CHBTC             | Y      |            |          |         | User-Defined |
| Cobinhood         | Y      | Y          |          |         | Y            |
| CoinEgg           | Y      | Y          | Y        |         | User-Defined |
| Coincheck         | Y      |            |          |         | User-Defined |
| Coinex            | Y      | Y          | Y        |         | Y            |
| Coinfalcon        | Y      | Y          | Y        |         | Y            |
| Coinfield         | Y      | N          | N        |         | Y            |
| Coingi            | Y      | Y          | Y        |         | Y            |
| CoinExchange      | Y      |            |          |         | Y            |
| Coinbene          | Y      | Y          | Y        |         | Y            |
| Coinhouse         | Y      |            |          |         | Y            |
| CoinJar           | Y      | Y          | Y        |         | Y            |
| Coinmate          | Y      | Y          |          |         | User-Defined |
| Coinnest          | Y      | Y          | Y        |         | User-Defined |
| Coinnox           | Y      | Y          | Y        |         | Y            |
| Coinroom          | Y      |            |          |         | Y            |
| Coinone           | Y      | Y          | Y        |         | Y            |
| Coinrail          | Y      | Y          | Y        |         | Y            |
| CoinsMarkets      | Y      |            |          |         | Y            |
| Coinsuper         | Y      |            |          |         | Y            |
| Coinstock         | Y      | Y          | Y        |         | Y            |
| COSS              | Y      |            |          |         | Y            |
| Cpdax             | Y      |            |          |         | Y            |
| Crex24            | Y      | Y          | Y        |         | Y            |
| CRXZone           | Y      | Y          | Y        |         | Y            |
| Cryptex           | Y      | Y          | Y        |         | User-Defined |
| CryptoBridge      | Y      |            |          |         | Y            |
| CryptoHub         | Y      | N          | N        |         | Y            |
| Cryptobulls       | Y      | N          | N        |         | Y            |
| Cryptopia         | Y      | Y          | Y        |         | Y            |
| Cybex             | Y      | Y          | Y        |         | Y            |
| Ddex              | Y      |            |          |         | Y            |
| Dsx               | Y      | Y          | Y        |         | Y            |
| Ercdex            | Y      | Y          |          |         | Y            |
| EtherDelta        | Y      |            |          |         | Y            |
| Ethfinex          | Y      | Y          | Y        |         | Y            |
| Exmo              | Y      | Y          | Y        |         | Y            |
| Exrates           | Y      | N          | N        |         | Y            |
| Extstock          | Y      | Y          | Y        |         | Y            |
| Exx               | Y      | Y          | Y        |         | Y            |
| F1cx              | Y      | Y          | Y        |         | Y            |
| Fex               | Y      | N          | N        |         | Y            |
| Fisco             | Y      | Y          | Y        |         | Y            |
| Forkdelta         | Y      | N          | N        |         | Y            |
| Freiexchange      | Y      | Y          |          |         | User-Defined |
| Gate              | Y      | Y          | Y        |         | Y            |
| Gatecoin          | Y      |            |          |         | Y            |
| GDAX              | Y      |            |          |         | Y            |
| Gemini            | Y      | Y          | Y        |         | Y            |
| GetBTC            | Y      | Y          | Y        |         | User-Defined |
| GOPAX             | Y      | Y          | Y        |         | Y            |
| Graviex           | Y      | N          | N        |         | Y            |
| Hadax             | Y      | N          | N        |         | Y            |
| HitBTC            | Y      |            |          |         | Y            |
| Hksy              | Y      |            | Y        |         | User-Defined |
| Huobi             | Y      |            |          |         | Y            |
| Idcm              | Y      |            |          |         | Y            |
| Idex              | Y      | Unstable   | Y        |         | Y            |
| InfinityCoin      | Y      |            |          |         | Y            |
| Itbit             | Y      | Y          | Y        |         | User-Defined |
| Jex               | Y      | N          | N        |         | Y            |
| Jubi              | Y      |            |          |         | Y            |
| KKex              | Y      | Y          | Y        |         | Y            |
| Kkcoin            | Y      | Y          | Y        |         | Y            |
| Koinex            | Y      |            |          |         | Y            |
| Koinok            | Y      |            |          |         | Y            |
| Korbit            | Y      |            |          |         | User-Defined |
| Kraken            | Y      |            |          |         | Y            |
| Kryptono          | Y      | Y          | Y        |         | User-Defined |
| Kucoin            | Y      | Y          | Y        |         | Y            |
| Kuna              | Y      | Y          | Y        |         | User-Defined |
| KyberNetwork      | Y      | N          | N        |         | Y            |
| LakeBTC           | Y      |            |          |         | Y            |
| Latoken           | Y      |            |          |         | Y            |
| Lbank             | Y      | Y          | Y        |         | Y            |
| Liqui             | Y      |            |          |         | Y            |
| LiteBit.eu        | Y      |            |          |         | Y            |
| Livecoin          | Y      |            |          |         | Y            |
| LocalBitcoins     | Y      | Y          | Y        |         | Y            |
| Luno              | Y      |            |          |         | Y            |
| Lykke             | Y      | Y          | N        |         | Y            |
| MercadoBitcoin    | Y      |            |          |         | User-Defined |
| Mercatox          | Y      | N          | N        | N       | Y            |
| Nanex             | Y      | N          | N        | N       | Y            |
| Neraex            | Y      | Y          | Y        |         | Y            |
| NLexch            | Y      |            |          |         | Y            |
| Novadex           | Y      | N          | N        |         | Y            |
| Nova Exchange     | Y      |            |          |         | Y            |
| OasisDEX          | Y      |            |          |         | Y            |
| OKCoin            | Y      |            |          |         | User-Defined |
| OKEx              | Y      | Y          | Y        |         | Y            |
| Ooobtc            | Y      | Y          | Y        |         | Y            |
| Openledger        | Y      | Y          | Y        |         | Y            |
| Ore Bz            | Y      | Y          | Y        |         | Y            |
| Paribu            | Y      |            |          |         | Y            |
| Paymium           | Y      | Y          | Y        |         | User-Defined |
| Poloniex          | Y      |            |          |         | Y            |
| Qryptos           | Y      |            |          |         | Y            |
| QuadrigaCX        | Y      |            |          |         | User-Defined |
| Quoine            | Y      |            |          |         | Y            |
| RadarRelay        | Y      |            |          |         | User-Defined |
| RightBTC          | Y      | Y          | Y        |         | Y            |
| Sigen             | Y      |            |          |         | Y            |
| Sistemkoin        | Y      |            |          |         | Y            |
| SouthXchange      | Y      | Y          | Y        |         | Y            |
| Stocks Exchange   | Y      |            |          |         | Y            |
| Switcheo          | Y      | N          | N        |         | Y            |
| SZZC              | Y      |            |          |         | Y            |
| The Rock Trading  | Y      |            |          |         | Y            |
| The Token Store   | Y      | Y          | Y        |         | Y            |
| Tidex             | Y      |            |          |         | Y            |
| Topbtc            | Y      | N          | N        |         | Y            |
| TradeOgre         | Y      | Y          | Y        |         | Y            |
| Trade Satoshi     | Y      |            |          |         | Y            |
| Trade.mn          | Y      | Y          | Y        |         | Y            |
| TrustDex \*\*     | Y      |            |          |         | Y            |
| TuxExchange       | Y      |            |          |         | Y            |
| Upbit             | Y      |            |          |         | Y            |
| Unocoin           |        |            |          |         |              |
| Vertpig           | Y      | Y          | N        |         | Y            |
| Viabtc            | Y      |            |          |         | User-Defined |
| Waves             | Y      | N          | Y        |         | Y            |
| Wcx               | Y      | Y          | Y        |         | Y            |
| Wex               | Y      | Y          | Y        |         | Y            |
| Yobit             | Y      |            |          |         | Y            |
| Yuanbao           | Y      |            |          |         | User-Defined |
| Yunbi             | Y      |            |          |         | Y            |
| Zaif              | Y      | Y          | Y        |         | Y            |
| ZB                | Y      | Y          | Y        |         | Y            |
| Zebpay            | Y      |            |          |         | User-Defined |

\*\* Mapping and data may be incorrect (Cannot determine correctness)

## Usage

### List market pairs supported by an exchange

```
  client = Cryptoexchange::Client.new
  pairs = client.pairs('bitflyer')
```

### List exchange services for certain currency

```
  client.exchange_for('btc')

  # ['anx', 'binance', ...]
```

### Query the Ticker API

```
  pair = client.pairs('bitflyer').first
  ticker = client.ticker(pair)
  ticker.base
  ticker.target
  ticker.last
```

### Query the OrderBook API

```
  # Check if exchange has support for OrderBook
  pair = client.pairs('bitflyer').first
  order_book = client.order_book(pair)
  order_book.base
  order_book.target
  order_book.bids
  order_book.asks
```

### Query the Trades API

```
  # Check if exchange has support for Trades
  # returns array

  pair = client.pairs('neraex').first
  trades = client.trades(pair)
  trades[0].base
  trades[0].target
  trades[0].price
  trades[0].amount
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
