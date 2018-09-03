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

| Exchange          | Ticker  | Order Book | Trade   | Account | Market List | Pair URL | slug              |
| ----------------- | ------- | ---------- | ------- | ------- | ----------- |----------|-------------------|
| 58Coin            | Y       | Y          | Y       |         | Y           | Y        | fifty_eight_coin  |
| Abcc              | Y       | N          | N       |         | Y           | Y        | abcc              |
| Abucoins          | Y       | Y          | Y       |         | Y           |          | abucoins          |
| ACX               | Y       | Y          | Y       |         | Y           | Y        | acx               |
| AEX               | Y       | Y          | Y       |         | Y           |          | aex               |
| Allcoin           | Y       | Y          |         |         | User-Defined|          | allcoin           |
| Altilly           | Y       | Y          | Y       |         | Y           | Y        | altilly           |
| ANX               | Y       |            |         |         | User-Defined|          | anx               |
| AXNET             | Y       | Y          | Y       |         | Y           | Y        | axnet             |
| B2BX              | Y       | Y          |         |         | Y           |          | b2bx              |
| Bancor            | Y       | N          | N       |         | Y           |          | bancor            |
| Bcex              | Y       | Y          | Y       |         | Y           | Y        | bcex              |
| Bibox             | Y       | Y          | Y       |         | Y           | Y        | bibox             |
| BigONE            | Y       | Y          | Y       |         | Y           | Y        | bigone            |
| Bilaxy            | Y       | Y          | Y       |         | Y           |          | bilaxy            |
| Binance           | Y       | Y          |         |         | Y           | Y        | binance           |
| Bisq              | Y       |            | Y       |         | Y           |          | bisq              |
| Bit2C             | Y       | Y          | Y       |         | User-Defined| Y        | bit2c             |
| Bit-Z             | Y       |            |         |         | Y           |          | bit_z             |
| Bitbank           | Y       | Y          | Y       |         | User-Defined| Y        | bitbank           |
| Bitbay            | Y       |            |         |         | User-Defined|          | bitbay            |
| BitBNS            | Y       |            |         |         | Y           |          | bitbns            |
| Bitbox            | Y       | Y          | Y       |         | Y           |          | bitbox            |
| Bitcoin Indonesia | Y       |            |         |         | User-Defined|          | bitcoin_indonesia |
| Bitconnect        | Y       |            |         |         | Y           |          | bitconnect        |
| Bitebtc           | Y       | Y          | Y       |         | Y           | Y        | bitebtc           |
| Bitfinex          | Y       |            |         |         | Y           |          | bitfinex          |
| Bitflyer          | Y       |            |         |         | Y           |          | bitflyer          |
| Bitforex          | Y       | N          | N       |         | Y           |          | bitforex          |
| Bithash           | Y       | Y          | Y       |         | Y           | Y        | bithash           |
| Bithumb           | Y       |            |         |         | Y           |          | bithumb           |
| Bitibu            | Y       | Y          | Y       |         | Y           | Y        | bitibu            |
| Bitinka           | Y       | Y          |         |         | Y           |          | bitinka           |
| Bitkonan          | Y       |            |         |         | User-Defined|          | bitkonan          |
| Bitlish           | Y       | Y          | Y       |         | Y           |          | bitlish           |
| Bitmart           | Y       | Y          | Y       |         | Y           |          | bitmart           |
| Bitmex            | Y       | Y          | Y       |         | Y           |          | bitmex            |
| Bitpaction        | Y       | Y          | Y       |         | Y           |          | bitpaction        |
| Bits Blockchain   | Y       | Y          |         |         | Y           |          | bits_blockchain   |
| Bitso             | Y       |            |         |         | Y           |          | bitso             |
| Bitstamp          | Y       | Y          | Y       |         | User-Defined|          | bitstamp          |
| Bittrex           | Y       |            |         |         | Y           |          | bittrex           |
| Bleutrade         | Y       |            |         |         | Y           |          | bleutrade         |
| Braziliex         | Y       | Y          | Y       |         | Y           |          | braziliex         |
| BTC38             |         |            |         |         |             |          |                   |
| BTC-e             |         |            |         |         |             |          |                   |
| BtcAlpha          | Y       | Y          | Y       |         | Y           | Y        | btc_alpha         |
| BtcTradeUa        | Y       | Y          | Y       |         | Y           | Y        | btc_trade_ua      |
| BTCBox            | Y       | Y          |         |         | User-Defined| Y        | btcbox            |
| BTCC              | Y       |            |         |         | User-Defined|          | btcc              |
| BTCChina          |         |            |         |         |             |          |                   |
| BTCMarkets        | Y       | Y          |         |         | Y           | Y        | btcmarkets        |
| Btcsquare         | Y       | Y          | Unstable|         | Y           | Y        | btcsquare         |
| BTCTurk           | Y       | Y          |         |         | Y           |          | btcturk           |
| BTER              | Y       |            |         |         | Y           |          | bter              |
| Buyucoin          | Y       | N          | N       |         | Y           |          | buyucoin          |
| BX Thailand       | Y       |            |         |         | Y           |          | bx_thailand       |
| C2CX              | Y       | Y          | N       |         | Y           |          | c2cx              |
| CPatex            | Y       | Y          | Y       |         | Y           |          | c_patex           |
| CCex              | Y       |            |         |         | Y           |          | ccex              |
| Cex               | Y       | Y          | Y       |         | Y           |          | cex               |
| Cfinex            | Y       | Y          | Y       |         | Y           | Y        | cfinex            |
| Chainrift         | Y       | Y          | Y       |         | Y           |          | chainrift         |
| Chaoex            | Y       | Y          | Y       |         | Y           | N        | chaoex            |
| CHBTC             | Y       |            |         |         | User-Defined|          | chbtc             |
| Cobinhood         | Y       | Y          |         |         | Y           | Y        | cobinhood         |
| Coin2001          | Y       | Y          | Y       |         | Y           |          | coin2001          |
| CoinEgg           | Y       | Y          | Y       |         | User-Defined| Y        | coin_egg          |
| CoinExchange      | Y       |            |         |         | Y           |          | coin_exchange     |
| Coinbene          | Y       | Y          | Y       |         | Y           | Y        | coinbene          |
| Coincheck         | Y       |            |         |         | User-Defined|          | coincheck         |
| Coinex            | Y       | Y          | Y       |         | Y           | Y        | coinex            |
| Coinfalcon        | Y       | Y          | Y       |         | Y           |          | coinfalcon        |
| Coinfield         | Y       | N          | N       |         | Y           | Y        | coinfield         |
| Coingi            | Y       | Y          | Y       |         | Y           | Y        | coingi            |
| Coinhouse         | Y       |            |         |         | Y           | Y        | coinhouse         |
| Coinhub           | Y       | Y          | Y       |         | Y           | Y        | coinhub           |
| CoinJar           | Y       | Y          | Y       |         | Y           |          | coinjar           |
| Coinmate          | Y       | Y          |         |         | User-Defined|          | coinmate          |
| Coinnest          | Y       | Y          | Y       |         | User-Defined| Y        | coinnest          |
| Coinnox           | Y       | Y          | Y       |         | Y           |          | coinnox           |
| Coinone           | Y       | Y          | Y       |         | Y           |          | coinone           |
| Coinrail          | Y       | Y          | Y       |         | Y           | Y        | coinrail          |
| Coinroom          | Y       |            |         |         | Y           |          | coinroom          |
| CoinsMarkets      | Y       |            |         |         | Y           |          | coin_markets      |
| Coinsbank         | Y       |            |         |         | Y           |          | coinsbank         |
| Coinstock         | Y       | Y          | Y       |         | Y           |          | coinstock         |
| Coinsuper         | Y       |            |         |         | Y           | Y        | coinsuper         |
| Cointiger         | Y       | Y          | Y       |         | Y           |          | cointiger         |
| Coinut            | Y       | Y          | Y       | Y       | Y           |          | coinut            |
| COSS              | Y       |            |         |         | Y           | Y        | coss              |
| Cpdax             | Y       | Y          | Y       |         | Y           |          | cpdax             |
| CredoEx           | Y       |            |         |         | Y           |          | credoex           |
| Crex24            | Y       | Y          | Y       |         | Y           | Y        | crex24            |
| CRXZone           | Y       | Y          | Y       |         | Y           | Y        | crxzone           |
| Cryptagio         | Y       | Y          | Y       |         | Y           | Y        | cryptagio         |
| Cryptex           | Y       | Y          | Y       |         | User-Defined| Y        | cryptex           |
| CryptoBridge      | Y       |            |         |         | Y           | Y        | crypto_bridge     |
| CryptoHub         | Y       | N          | N       |         | Y           |          | crypto_hub        |
| Cryptobulls       | Y       | N          | N       |         | Y           |          | cryptobulls       |
| Cryptonit         | Y       | Y          | Y       |         | Y           | Y        | cryptonit         |
| Cryptopia         | Y       | Y          | Y       |         | Y           |          | cryptopia         |
| Crytrex           | Y       | Y          | Y       |         | Y           |          | crytrex           |
| Cybex             | Y       | Y          | Y       |         | Y           |          | cybex             |
| Ddex              | Y       |            |         |         | Y           | Y        | ddex              |
| DEx.top           | Y       | Y          | Y       |         | Y           |          | dextop            |
| Digifinex         | Y       |            |         |         | Y           |          | digifinex         |
| Dobitrade         | Y       | Y          | N       |         | Y           |          | dobitrade         |
| Dsx               | Y       | Y          | Y       |         | Y           |          | dsx               |
| Ercdex            | Y       | Y          |         |         | Y           |          | erxdex            |
| Escodex           | Y       |            |         |         | Y           | Y        | escodex           |
| EtherDelta        | Y       |            |         |         | Y           |          | ether_delta       |
| Ethfinex          | Y       | Y          | Y       |         | Y           |          | ethfinex          |
| Exmo              | Y       | Y          | Y       |         | Y           | Y        | exmo              |
| Exrates           | Y       | N          | N       |         | Y           |          | exrates           |
| Extstock          | Y       | Y          | Y       |         | Y           | Y        | extstock          |
| Exx               | Y       | Y          | Y       |         | Y           | Y        | exx               |
| F1cx              | Y       | Y          | Y       |         | Y           | Y        | f1cx              |
| Fcoin             | Y       | Y          | Y       |         | Y           | Y        | fcoin             |
| Fex               | Y       | N          | N       |         | Y           |          | fex               |
| Fisco             | Y       | Y          | Y       |         | Y           | Y        | fisco             |
| Forkdelta         | Y       | N          | N       |         | Y           | Y        | forkdelta         |
| Freiexchange      | Y       | Y          |         |         | User-Defined| Y        | freiexchange      |
| Gate              | Y       | Y          | Y       |         | Y           | Y        | gate              |
| Gatecoin          | Y       |            |         |         | Y           |          | gatecoin          |
| GDAX              | Y       |            |         |         | Y           |          | gdax              |
| Gemini            | Y       | Y          | Y       |         | Y           |          | gemini            |
| GetBTC            | Y       | Y          | Y       |         | User-Defined| Y        | getbtc            |
| Gibraltar         | Y       | N          | N       |         | Y           | Y        | gbx               |     
| GOPAX             | Y       | Y          | Y       |         | Y           | Y        | gopax             |
| Graviex           | Y       | N          | N       |         | Y           |          | graviex           |
| Hadax             | Y       | N          | N       |         | Y           | Y        | hadax             |
| Hikenex           | Y       | N          | N       |         | Y           | N        | hikenex           |
| HitBTC            | Y       |            |         |         | Y           |          | hitbtc            |
| Hotbit            | Y       | N          | N       |         | Y           | Y        | hotbit            |
| Huobi             | Y       |            |         |         | Y           | Y        | huobi             |
| Idax              | Y       | N          | N       |         | Y           | Y        | idax              |
| Idcm              | Y       |            |         |         | Y           | Y        | idcm              |
| Idex              | Y       | Unstable   | Y       |         | Y           | Y        | idex              |
| InfinityCoin      | Y       |            |         |         | Y           | Y        | infinity_coin     |
| InstantBitex      | Y       | Y          | Y       |         | Y           |          | instantbitex
| Itbit             | Y       | Y          | Y       |         | User-Defined|          | itbit             |
| Jex               | Y       | N          | N       |         | Y           |          | jex               |
| Joyso             | Y       | Y          |         |         | Y           |          | joyso             |
| Jubi              | Y       |            |         |         | Y           |          | jubi              |
| KKex              | Y       | Y          | Y       |         | Y           | Y        | k_kex             |
| Kkcoin            | Y       | Y          | Y       |         | Y           | Y        | kkcoin            |
| Koinex            | Y       |            |         |         | Y           |          | koinex            |
| Koinok            | Y       |            |         |         | Y           | Y        | koinok            |
| Korbit            | Y       |            |         |         | User-Defined|          | korbit            |
| Kraken            | Y       |            |         |         | Y           |          | kraken            |
| Kryptono          | Y       | Y          | Y       |         | User-Defined| Y        | kryptono          |
| Kucoin            | Y       | Y          | Y       |         | Y           | Y        | kucoin            |
| Kuna              | Y       | Y          | Y       |         | User-Defined| Y        | kuna              |
| KyberNetwork      | Y       | N          | N       |         | Y           | Y        | kyber_network     |
| LakeBTC           | Y       |            |         |         | Y           |          | lakebtc           |
| Latoken           | Y       |            |         |         | Y           | Y        | latoken           |
| Lbank             | Y       | Y          | Y       |         | Y           | Y        | lbank             |
| Liqui             | Y       |            |         |         | Y           |          | liqui             |
| LiteBit.eu        | Y       |            |         |         | Y           |          | litebiteu         |
| Livecoin          | Y       |            |         |         | Y           |          | livecoin          |
| Luno              | Y       |            |         |         | Y           |          | luno              |
| Lykke             | Y       | Y          | N       |         | Y           |          | lykke             |
| MaxMaicoin        | Y       | Y          | Y       |         | Y           |          | max_maicoin       |
| MercadoBitcoin    | Y       |            |         |         | User-Defined|          | mercado_bitcoin   |
| Mercatox          | Y       | N          | N       | N       | Y           |          | mercatox          |
| Myspeedtrade      | Y       | Y          |         |         | Y           |          | myspeedtrade      |
| Nanex             | Y       | N          | N       | N       | Y           |          | nanex             |
| Nebula            | Y       | N          | Y       |         | Y           |          | nebula            |
| Negociecoins      | Y       | Y          | Y       |         | User-Defined|          | negociecoins      |
| Neraex            | Y       | Y          | Y       |         | Y           | Y        | neraex            |
| Ninecoin          | Y       |            |         |         | Y           |          | ninecoin          |
| NLexch            | Y       |            |         |         | Y           | Y        | nlexch            |
| Novadex           | Y       | N          | N       |         | Y           | Y        | novadex           |
| Nova Exchange     | Y       |            |         |         | Y           |          | novaexchange      |
| OasisDEX          | Y       |            |         |         | Y           |          | oasisdex          |
| Octaex            | Y       | Y          | Y       |         | Y           |          | octaex            |
| OKCoin            | Y       |            |         |         | User-Defined|          | okcoin            |
| OKEx              | Y       | Y          | Y       |         | Y           | Y        | okex              |
| OmniTrade         | Y       | Y          | Y       | Y       | Y           |          | omnitrade         |
| Ooobtc            | Y       | Y          | Y       |         | Y           | Y        | ooobtc            |
| Openledger        | Y       | Y          | Y       |         | Y           | Y        | openledger        |
| OrderBook         | Y       | Y          | Y       |         | Y           | Y        | orderbook         |
| Ore Bz            | Y       | Y          | Y       |         | Y           | Y        | ore_bz            |
| OTCBTC            | Y       | Y          | Y       |         | Y           |          | otcbtc            |
| P2pb2b            | Y       |            |         |         | Y           |          | p2pb2b            |
| Paribu            | Y       |            |         |         | Y           |          | paribu            |
| Paro Exchange     | Y       |            |         |         | Y           |          | paroexchange      |
| Paymium           | Y       | Y          | Y       |         | User-Defined|          | paymium           |
| Poloniex          | Y       |            |         |         | Y           |          | poloniex          |
| QBTC              | Y       | Y          | Y       |         | Y           |          | qbtc              |
| Qryptos           | Y       |            |         |         | Y           |          | qryptos           |
| QuadrigaCX        | Y       |            |         |         | User-Defined|          | quadrigacx        |
| Quoine            | Y       |            |         |         | Y           |          | quoine            |
| RadarRelay        | Y       |            |         |         | Y           | Y        | radar_relay       |
| Rfinex            | Y       | Y          | Y       |         | Y           |          | rfinex            |
| RightBTC          | Y       | Y          | Y       |         | Y           |          | rightbtc          |
| SafeTrade         | Y       | N          | N       |         | Y           |          | safe_trade        |
| Sigen             | Y       |            |         |         | Y           | Y        | sigen             |
| Simex             | Y       | N          | N       |         | Y           | Y        | simex             |
| Singularx         | Y       | N          | N       |         | Y           |          | singularx         |
| Sistemkoin        | Y       |            |         |         | Y           |          | sistemkoin        |
| SouthXchange      | Y       | Y          | Y       |         | Y           | Y        | south_xchange     |
| Stocks Exchange   | Y       |            |         |         | Y           | Y        | stocks_exchange   |
| Switcheo          | Y       | N          | N       |         | Y           | Y        | switcheo          |
| Syex              | Y       | N          | N       |         | Y           | Y        | syex              |
| SZZC              | Y       |            |         |         | Y           |          | szzc              |
| Tdax              | Y       | N          | Y       |         | Y           |          | tdax              |
| The Rock Trading  | Y       |            |         |         | Y           |          | therocktrading    |
| The Token Store   | Y       | Y          | Y       |         | Y           | Y        | thetokenstore     |
| Thinkbit          | Y       | Y          | Y       |         | Y           |          | thinkbit          |
| Tidebit           | Y       | Y          | Y       |         | Y           |          | tidebit           |
| Tidex             | Y       |            |         |         | Y           |          | tidex             |
| Tokenjar          | Y       |            |         |         | Y           |          | tokenjar          |
| Tokenomy          | Y       | Y          | Y       |         | Y           | Y        | tokenomy          |
| Topbtc            | Y       | N          | N       |         | Y           | Y        | topbtc            |
| TradeOgre         | Y       | Y          | Y       |         | Y           | Y        | trade_ogre        |
| Trade Satoshi     | Y       |            |         |         | Y           | Y        | trade_satoshi     |
| Trade.mn          | Y       | Y          | Y       |         | Y           |          | trademn           |
| TrocaNinja        | Y       | N          | N       |         | Y           |          | troca_ninja       |
| TrustDex **       | Y       |            |         |         | Y           |          | trust_dex         |
| TuxExchange       | Y       |            |         |         | Y           |          | tux_exchange      |
| Unocoin           |         |            |         |         |             |          | unocoin           |
| Upbit             | Y       | Y          | Y       |         | Y           | Y        | upbit             |
| Vebitcoin         | Y       | N          | N       |         | Y           | N        | vebitcoin         |
| Vertpig           | Y       | Y          | N       |         | Y           | Y        | vertpig           |
| Viabtc            | Y       |            |         |         | User-Defined|          | viabtc            |
| Waves             | Y       | N          | Y       |         | Y           |          | waves             |
| Wcx               | Y       | Y          | Y       |         | Y           |          | wcx               |
| Wex               | Y       | Y          | Y       |         | Y           | Y        | wex               |
| Yobit             | Y       |            |         |         | Y           |          | yobit             |
| Yuanbao           | Y       |            |         |         | User-Defined|          | yuanbao           |
| Yunbi             | Y       |            |         |         | Y           |          | yunbi             |
| Zaif              | Y       | Y          | Y       |         | Y           | Y        | zaif              |
| ZB                | Y       | Y          | Y       |         | Y           | Y        | zb                |
| Zebpay            | Y       |            |         |         | Y           |          | Zebpay            |

** Mapping and data may be incorrect (Cannot determine correctness)

*** User-Defined requires pair id

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
  pair = client.pairs('bitbank').first
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

### Get Exchange Trade URL (Work in Progress)

```
  client.trade_page_url 'binance', base: 'BTC', target: 'USDT'

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
