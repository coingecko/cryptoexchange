[![Build Status](https://travis-ci.org/coingecko/cryptoexchange.svg)](https://travis-ci.org/coingecko/cryptoexchange)

# Cryptoexchange

Cryptoexchange is a rubygem for ruby developers to interact with over 200+ cryptocurrency exchange market data APIs in a single library.

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

| Exchange          | Ticker  | Order Book | Trade   | Account | Market List | Pair URL | slug              |m.type |
| ----------------- | ------- | ---------- | ------- | ------- | ----------- |----------|-------------------|-------|
| 58Coin            | Y       | Y          | Y       |         | Y           | Y        | fifty_eight_coin  |       |
| Abcc              | Y       | N          | N       |         | Y           | Y        | abcc              |       |
| Abucoins          | Y       | Y          | Y       |         | Y           |          | abucoins          |       |
| ACX               | Y       | Y [x]      | Y       |         | Y           | Y        | acx               |       |
| AEX               | Y       | Y          | Y       |         | Y           |          | aex               |       |
| Airswap           | Y       |            |         |         |             |          | airswap           |       |
| Allbit            | Y       | N          | N       |         | Y           | Y        | allbit            |       |
| Allcoin           | Y       | Y [x]      | Y       |         | Y           |          | allcoin           |       |
| Alluma            | Y       | N          | N       |         | Y           | N        | alluma            |       |
| Alterdice         | Y       |            |         |         | Y           | Y        | alterdice         |       |
| Altilly           | Y       | Y [x]      | Y       |         | Y           | Y        | altilly           |       |
| Altmarkets        | Y       | Y [x]      | Y       |         | Y           | Y        | altmarkets        |       |
| ANX               | Y       |            |         |         | User-Defined|          | anx               |       |
| Aphelion          | Y       |            |         |         | Y           | Y        | aphelion          |       |
| AXNET (halted)    | Y       | Y          | Y       |         | Y           | Y        | axnet             |       |
| B2BX              | Y       | N          |         |         | Y           |          | b2bx              |       |
| Bancor            | Y       | N          | N       |         | Y           |          | bancor            |       |
| Bankera           | Y       | Y [x]      | Y       |         | Y           | Y        | bankera           |       |
| Bcex (halted)     | Y       | Y          | Y       |         | Y           | Y        | bcex              |       |
| Bcoin             | Y       |            |         |         | Y           | Y        | bcoin             |       |
| Bgogo             | Y       | Y [x]      | Y       |         | Y           | Y        | bgogo             |       |
| Bibox             | Y       | Y [x]      | Y       |         | Y           | Y        | bibox             |       |
| Bigmarkets        | Y       |            |         |         | Y           | Y        | bigmarkets        |       |
| BigONE            | Y       | Y [x]      | Y       |         | Y           | Y        | bigone            |       |
| Biki              | Y       | Y [x]      |         |         | Y           | Y        | biki              |       |
| Bilaxy            | Y       | Y [x]      | Y       |         | Y           | Y        | bilaxy            |       |
| Binance           | Y       | Y [x]      | Y [x]   |         | Y           | Y        | binance           |       |
| Binance DEX       | Y       |            |         |         | Y           |          | binance_dex       |       |
| Binance Jersey    | Y       | Y [x]      |         |         | Y           | Y        | binance_jersey    |       |
| Binance Uganda    | Y       | Y [x]      |         |         | Y           | Y        | binance_uganda    |       |
| Bione             | Y       | Y [x]      |         |         | Y           |          | bione             |       |
| Bishang           | Y       |            |         |         | Y           |          | bishang           |       |
| Bisq              | Y       |            | Y       |         | Y           |          | bisq              |       |
| Bit2C             | Y       | Y [x]      | Y       |         | User-Defined| Y        | bit2c             |       |
| Bit-Z             | Y       |            |         |         | Y           |          | bit_z             |       |
| Bitalong          | Y       | Y [x]      | Y       |         | Y           | Y        | bitalong          |       |
| Bitasset          | Y       | Y [x]      | Y       |         | Y           | Y        | bitasset          |       |
| Bitbank           | Y       | Y [x]      | Y       |         | User-Defined| Y        | bitbank           |       |
| Bitbay            | Y       |            |         |         | User-Defined|          | bitbay            |       |
| Bitbegin          | Y       | N          | N       |         | Y           | Y        | bitbegin          |       |
| BitBNS            | Y       |            |         |         | Y           |          | bitbns            |       |
| Bitbox (Auth)     | Y       |            |         |         | User-Defined| Y        | bitbox            |       |
| Bitbox (Public)   | Y       |            |         |         | Y           | Y        | bitbox            |       |
| Bitc3             | Y       | N          | N       |         | Y           | Y        | bitc3             |       |
| Bitconnect        | Y       |            |         |         | Y           |          | bitconnect        |       |
| Bitebtc           | Y       | Y [x]      | Y       |         | Y           | Y        | bitebtc           |       |
| Bitex.la          | Y       | Y [x]      |         |         | Y           |          | bitex             |       |
| Bitexbook         | Y       | N          | N       |         | Y           | Y        | bitexbook         |       |
| Bitexlive         | Y       | N          | N       |         | Y           | Y        | bitexlive         |       |
| BitFex.Trade      | Y       |            |         |         | Y           | Y        | bitfex            |       |
| Bitfinex          | Y       | Y [x]      |         |         | Y           |          | bitfinex          |       |
| Bitflyer          | Y       | Y [x]      |         |         | Y           |          | bitflyer          |       |
| Bitforex          | Y       | Y [x]      | N       |         | Y           |          | bitforex          |       |
| Bithash           | Y       | Y [x]      | Y       |         | Y           | Y        | bithash           |       |
| Bitholic          | Y       | Y [x]      | Y       |         | Y           |          | bitholic          |       |
| Bithumb           | Y       | Y [x]      |         |         | Y           |          | bithumb           |       |
| Bithumb Global    | Y       | Y [x]      | Y       |         | Y           | Y        | bithumb_global    |       |
| Bitibu            | Y       | Y [x]      | Y       |         | Y           | Y        | bitibu            |       |
| Bitinfi           | Y       | Y [x]      |         |         | Y           |          | bitinfi           |       |
| Bitinka           | Y       | Y [x]      |         |         | Y           |          | bitinka           |       |
| Bitker            | Y       |            |         |         | Y           | Y        | bitker            |       |
| Bitkonan          | Y       |            |         |         | User-Defined|          | bitkonan          |       |
| Bitkub            | Y       | Y [x]      | Y       |         | Y           | Y        | bitkub            |       |
| Bitlish           | Y       | Y [x]      | Y       |         | Y           |          | bitlish           |       |
| Bitmart           | Y       | Y [x]      | Y       |         | Y           |          | bitmart           |       |
| Bitmax            | Y       | Y [x]      | Y       |         | Y           | Y        | bitmax            |       |
| Bitmesh           | Y       | N          | N       |         | Y           | Y        | bitmesh           |       |
| Bitmex            | Y       | Y          | Y       |         | Y           |          | bitmex            |futures|
| BitOnBay          | Y       |            |         |         | Y           |          | bitonbay          |       |
| Bitopro           | Y       | Y [x]      | Y       |         | User-Defined| Y        | bitopro           |       |
| Bitpaction[halted]| Y       | Y          | Y       |         | Y           |          | bitpaction        |       |
| Bitrabbit         | Y       | N          | N       |         | Y           | Y        | bitrabbit         |       |
| Bitrue            | Y       | Y [x]      |         |         | Y           | Y        | bitrue            |       |
| Bits Blockchain   | Y       | Y          |         |         | Y           |          | bits_blockchain   |       |
| Bitsane           | Y       | Y [x]      |         |         | Y           |          | bitsane           |       |
| Bitshares Assets  | Y       |            |         |         | User-Defined|          | bitshares_assets  |       |
| Bitso             | Y       |            |         |         | Y           |          | bitso             |       |
| Bitstamp          | Y       | Y [x]      | Y       |         | User-Defined|          | bitstamp          |       |
| Bitsten           | Y       | Y [x]      | N       |         | Y           | Y        | bitsten           |       |
| Bitstorage        | Y       | Y [x]      | Y       |         | Y           | Y        | bitstorage        |       |
| Bittrex           | Y       | Y [x]      |         |         | Y           | Y        | bittrex           |       |
| Bkex              | Y       | N          | N       |         | Y           | Y        | bkex              |       |
| Bleutrade         | Y       |            |         |         | Y           |          | bleutrade         |       |
| Blockonix         | Y       | Y          | Y       |         | Y           |          | blockonix         |       |
| Blokmy            | Y       | Y          | Y       |         | Y           | Y        | blokmy            |       |
| Braziliex (halted)| Y       | Y          | Y       |         | Y           |          | braziliex         |       |
| BTC38             |         |            |         |         |             |          |                   |       |
| BTC-e             |         |            |         |         |             |          |                   |       |
| BtcAlpha          | Y       | Y [x]      | Y       |         | Y           | Y        | btc_alpha         |       |
| BTC Exchange      | Y       | Y          | Y       |         | Y           | Y        | btc_exchange      |       |
| BtcTradeUa        | Y       | Y          | Y       |         | Y           | Y        | btc_trade_ua      |       |
| BTCBox            | Y       | Y          |         |         | User-Defined| Y        | btcbox            |       |
| BTCC              | Y       |            |         |         | User-Defined|          | btcc              |       |
| BTCEXA            | Y       | Y [x]      |         |         | Y           |          | btcexa            |       |
| BTCChina          |         |            |         |         |             |          |                   |       |
| BTCMarkets        | Y       | Y          |         |         | Y           | Y        | btcmarkets        |       |
| Btcsquare         | Y       | Y          | Unstable|         | Y           | Y        | btcsquare         |       |
| BTCTurk           | Y       | Y          |         |         | Y           |          | btcturk           |       |
| BTER              | Y       |            |         |         | Y           |          | bter              |       |
| Buyucoin          | Y       | N          | N       |         | Y           |          | buyucoin          |       |
| BX Thailand       | Y       | Y [x]      |         |         | Y           |          | bx_thailand       |       |
| BW                | Y       |            |         |         | Y           | Y        | bw                |       |
| Bytex             | Y       | N          | N       |         | Y           | N        | bytex             |       |
| C2CX              | Y       | Y [x]      | N       |         | Y           |          | c2cx              |       |
| CPatex            | Y       | Y [x]      | Y       |         | Y           |          | c_patex           |       |
| Cbx               | Y       | Y [x]      | Y       |         | Y           | Y        | cbx               |       |
| CCex              | Y       |            |         |         | Y           |          | ccex              |       |
| Ccx               | Y       |            |         |         | Y           | Y        | ccx               |       |
| Cex               | Y       | Y [x]      | Y       |         | Y           |          | cex               |       |
| Cfinex            | Y       | Y          | Y       |         | Y           | Y        | cfinex            |       |
| Chaince           | Y       |            |         |         | Y           | Y        | chaince           |       |
| Chainrift         | Y       | Y [x]      | Y       |         | Y           |          | chainrift         |       |
| ChainEX           | Y       | Y [x]      | Y       |         | Y           |          | chainex           |       |
| Chaoex            | Y       | Y [x]      | Y       |         | Y           | N        | chaoex            |       |
| CHBTC             | Y       |            |         |         | User-Defined|          | chbtc             |       |
| Citex             | Y       | N          | N       |         | Y           | Y        | citex             |       |
| Cobinhood         | Y       | Y [x]      |         |         | Y           | Y        | cobinhood         |       |
| CODEX             | Y       | Y          | Y       |         | Y           |          | codex             |       |
| Coin2001          | Y       | Y          | Y       |         | Y           |          | coin2001          |       |
| Coinall           | Y       | Y [x]      | Y       |         | Y           |          | coinall           |       |
| Coin Asset        | Y       | Y          | Y       |         | Y           |          | coinasset         |       |
| Coinchangex       | Y       | N          | N       |         | Y           | Y        | coinchangex       |       |
| CoinEgg           | Y       | Y [x]      | Y       |         | User-Defined| Y        | coin_egg          |       |
| CoinExchange      | Y       |            |         |         | Y           |          | coin_exchange     |       |
| Coinbe            | Y       |            |         |         | Y           |          | coinbe            |       |
| Coinbene          | Y       | Y [x]      | Y       |         | Y           | Y        | coinbene          |       |
| Coinbig           | Y       | Y [x]      |         |         | Y           | Y        | coinbig           |       |
| Coinbit           | Y       | N          | N       |         | Y           | Y        | coinbit           |       |
| Coincheck         | Y       | Y [x]      |         |         | User-Defined|          | coincheck         |       |
| Coindeal          | Y       | Y [x]      |         |         | Y           |          | coindeal          |       |
| Coindirect        | Y       | N          | N       |         | Y           | Y        | coindirect        |       |
| Coineal           | Y       | Y [broken] | Y       |         | Y           |          | coineal           |       |
| Coinex            | Y       | Y [x]      | Y       |         | Y           | Y        | coinex            |       |
| Coinexmarket (broken)| Y       | Y          | Y       |         | Y           |          | coinexmarket      |       |
| Coinfalcon        | Y       | Y [x]      | Y       |         | Y           |          | coinfalcon        |       |
| Coinfield         | Y       | Y [x]      | Y       |         | Y           | Y        | coinfield         |       |
| Coingi            | Y       | Y [x]      | Y       |         | Y           | Y        | coingi            |       |
| Coinhouse         | Y       |            |         |         | Y           | Y        | coinhouse         |       |
| Coinhub           | Y       | Y          | Y       |         | Y           | Y        | coinhub           |       |
| CoinJar           | Y       | Y [x]      | Y       |         | Y           | Y        | coinjar           |       |
| Coinlim           | Y       | N          | N       |         | Y           | N        | coinlim           |       |
| Coinmate          | Y       | Y          |         |         | User-Defined|          | coinmate          |       |
| Coinmetro         | Y       |            |         |         |             |          | coin_metro        |       |
| Coinmex           | Y       | Y [x]      | Y       |         | Y           |          | coinmex           |       |
| Coinnest          | Y       | Y [x]      | Y       |         | User-Defined| Y        | coinnest          |       |
| Coinnox           | Y       | Y          | Y       |         | Y           |          | coinnox           |       |
| Coinone           | Y       | Y [x]      | Y       |         | Y           | Y        | coinone           |       |
| Coinpark          | Y       | Y          | Y       |         | Y           | Y        | coinpark          |       |
| Coinplace         | Y       |            |         |         | Y           |          | coinplace         |       |
| Coinrail [broken] | Y       | Y          | Y       |         | Y           | Y        | coinrail          |       |
| Coinroom          | Y       |            |         |         | Y           |          | coinroom          |       |
| CoinsMarkets      | Y       |            |         |         | Y           |          | coin_markets      |       |
| Coinsbank         | Y       |            |         |         | Y           |          | coinsbank         |       |
| Coinsbit          | Y       |            |         |         | Y           |          | coinsbit          |       |
| Coinstock         | Y       | Y          | Y       |         | Y           |          | coinstock         |       |
| Coinsuper         | Y       | N [Not Found] |         |         | Y           | Y        | coinsuper         |       |
| Cointiger         | Y       | Y [x]      | Y       |         | Y           |          | cointiger         |       |
| Coinut (Auth)     | Y       | Y          | Y       | Y       | Y           |          | coinut            |       |
| Coinxpro          | Y       | Y          |         |         | Y           | Y        | coinxpro          |       |
| Coinzest          | Y       | Y [x]      |         |         | Y           |          | coinzest          |       |
| Coinzo            | Y       | Y          | Y       |         | Y           | Y        | coinzo            |       |
| COSS              | Y       |            |         |         | Y           | Y        | coss              |       |
| Cpdax             | Y       | Y [x]      | Y       |         | Y           |          | cpdax             |       |
| CredoEx           | Y       |            |         |         | Y           |          | credoex           |       |
| Crex24            | Y       | Y [x]      | Y       |         | Y           | Y        | crex24            |       |
| CRXZone           | Y       | Y [x]      | Y       |         | Y           | Y        | crxzone           |       |
| Cryptagio         | Y       | Y          | Y       |         | Y           | Y        | cryptagio         |       |
| Cryptaldash       | Y       | Y          | Y       |         | Y           |          | cryptaldash       |       |
| Cryptex           | Y       | Y          | Y       |         | User-Defined| Y        | cryptex           |       |
| CryptoBridge      | Y       |            |         |         | Y           | Y        | crypto_bridge     |       |
| CryptoHub         | Y       | N          | N       |         | Y           |          | crypto_hub        |       |
| Cryptobulls       | Y       | N          | N       |         | Y           |          | cryptobulls       |       |
| Cryptology        | Y       |            |         |         | Y           |          | cryptology        |       |
| Cryptonit         | Y       | Y          | Y       |         | Y           | Y        | cryptonit         |       |
| Cryptopia         | Y       | Y          | Y       |         | Y           |          | cryptopia         |       |
| Crytrex           | Y       | Y          | Y       |         | Y           |          | crytrex           |       |
| Cybex             | Y       |            | Y       |         | Y           |          | cybex             |       |
| Dakuce            | Y       | Y          | Y       |         | Y           |          | dakuce            |       |
| Daybit            | Y       |            |         |         | Y           | Y        | daybit            |       |
| Dcoin             | Y       | N          | N       |         | Y           | Y        | dcoin             |       |
| Ddex              | Y       | Y          | Y       |         | Y           | Y        | ddex              |       |
| DEEX              | Y       |            |         |         | Y           |          | deex              |       |
| Deribit           | Y       | Y          | Y       | Y       | Y           | Y        | deribit           |futures|
| DEx.top           | Y       | Y [x]      | Y       |         | Y           |          | dextop            |       |
| dex-trade         | Y       |            |         |         | Y           |          | dextrade          |       |
| Dflow             | Y       |            |         |         | Y           | Y        | dflow             |       |
| Digifinex         | Y       |            |         |         | Y           |          | digifinex         |       |
| Digitalprice      | Y       | Y          | Y       |         | Y           | Y        | digitalprice      |       |
| Dobitrade         | Y       | Y [x]      | N       |         | Y           | Y        | dobitrade         |       |
| Dragonex          | Y       | Y [x]      | N       |         | Y           | Y        | dragonex          |       |
| Dsx               | Y       | Y          | Y       |         | Y           |          | dsx               |       |
| Eosex             | Y       | N          | N       |         | Y           | Y        | eosex             |       |
| Ecxx              | Y       | N          | N       |         | Y           | Y        | ecxx              |       |
| Ercdex            | Y       | Y          |         |         | Y           |          | erxdex            |       |
| Escodex           | Y       |            |         |         | Y           | Y        | escodex           |       |
| EtherDelta        | Y       |            |         |         | Y           |          | ether_delta       |       |
| Etherflyer        | Y       | N          | N       |         | Y           | Y        | etherflyer        |       |
| Ethex             | Y       | N          | N       |         | Y           | N        | ethex             |       |
| Ethfinex          | Y       | Y [x]      | Y       |         | Y           | Y        | ethfinex          |       |
| Everbloom         | Y       |            |         |         | Y           |          | everbloom         |       |
| ExMarkets         | Y       | Y          | Y       |         | Y           | Y        | exmarkets         |       |
| Exmo              | Y       | Y [x]      | Y       |         | Y           | Y        | exmo              |       |
| Exrates           | Y       | Y [x]      | N       |         | Y           | Y        | exrates           |       |
| Extstock          | Y       | Y          | Y       |         | Y           | Y        | extstock          |       |
| Exx               | Y       | Y [x]      | Y       |         | Y           | Y        | exx               |       |
| F1cx              | Y       | Y          | Y       |         | Y           | Y        | f1cx              |       |
| FatBTC            | Y       | Y [x]      | Y       |         | Y           |          | fatbtc            |       |
| Fcoin             | Y       | Y [x]      | Y       |         | Y           | Y        | fcoin             |       |
| Fex               | Y       | N          | N       |         | Y           |          | fex               |       |
| Financex          | Y       | N          | N       |         | Y           | Y        | financex          |       |
| Fisco             | Y       | Y          | Y       |         | Y           | Y        | fisco             |       |
| Floatsv           | Y       | Y [x]      |         |         | Y           | Y        | floatsv           |       |
| Forkdelta         | Y       | N          | N       |         | Y           | Y        | forkdelta         |       |
| Freiexchange      | Y       | Y          |         |         | User-Defined| Y        | freiexchange      |       |
| FinexBox          | Y       | Y [x]      |         |         | Y           | Y        | finexbox          |       |
| Fubt              | Y       |            |         |         | Y           | Y        | fubt              |       |
| Gate              | Y       | Y [x]      | Y       |         | Y           | Y        | gate              |       |
| Gate (Futures)    | Y       | Y [x]      | Y       |         | Y           | Y        | gate_futures      |futures|
| Gatecoin          | Y       |            |         |         | Y           |          | gatecoin          |       |
| GDAX(Coinbase Pro)| Y       | Y [x]      |         |         | Y           | Y        | gdax              |       |
| Gemini            | Y       | Y [x]      | Y       |         | Y           |          | gemini            |       |
| GetBTC            | Y       | Y          | Y       |         | User-Defined| Y        | getbtc            |       |
| Gibraltar         | Y       | N          | N       |         | Y           | Y        | gbx               |       |
| Gobaba            | Y       |            |         |         | Y           |          | gobaba            |       |
| golix (API Failed)| Y       | Y          |         |         | Y           |          | golix             |       |
| GOPAX             | Y       | Y [x]      | Y       |         | Y           | Y        | gopax             |       |
| Graviex           | Y       | N          | N       |         | Y           |          | graviex           |       |
| Hadax             | Y       | N          | N       |         | Y           | Y        | hadax             |       |
| Hb.top            | Y       | Y [x]      | N       |         | Y           | N        | hb_top            |       |
| Hikenex           | Y       | N          | N       |         | Y           | N        | hikenex           |       |
| HitBTC            | Y       | Y [x]      | Y       |         | Y           | Y        | hitbtc            |       |
| Hotbit            | Y       | Y [x]      | N       |         | Y           | Y        | hotbit            |       |
| HPX               | Y       | Y [x]      | Y       |         | Y           |          | hpx               |       |
| Hubi              | Y       |            |         |         | Y           |          | hubi              |       |
| Huobi             | Y       | Y [x]      |         |         | Y           | Y        | huobi             |       |
| Huobi US          | Y       | Y [x]      |         |         | Y           | Y        | huobi_us          |       |
| Ice3x             | Y       | Y          | Y       |         | Y           |          | ice3x             |       |
| Idax              | Y       | Y [x]      | N       |         | Y           | Y        | idax              |       |
| Idcm              | Y       |            |         |         | Y           | Y        | idcm              |       |
| Idex              | Y       | Unstable   | Y       |         | Y           | Y        | idex              |       |
| Incorex           | Y       | Y          | Y       |         | Y           | Y        | incorex           |       |
| Indodax           | Y       | Y [x]      | Y       |         | User-Defined| N        | indodax           |       |
| IndependentReserve| Y       | N          | N       |         | Y           | Y        |independent_reserve|       |
| InfinityCoin      | Y       |            |         |         | Y           | Y        | infinity_coin     |       |
| InstantBitex      | Y       | Y          | Y       |         | Y           |          | instantbitex      |       |
| Iqfinex           | Y       | Y          | Y       |         | Y           | Y        | iqfinex           |       |
| Ironex            | Y       |            |         |         | Y           |          | ironex            |       |
| Itbit             | Y       | Y [x]      | Y       |         | User-Defined|          | itbit             |       |
| Jex               | Y       | N          | N       |         | Y           |          | jex               |       |
| Joyso             | Y       | Y [x]      |         |         | Y           |          | joyso             |       |
| Jubi              | Y       |            |         |         | Y           |          | jubi              |       |
| Kairex            | Y       | Y [x]      |         |         | Y           |          | kairex            |       |
| KKex              | Y       | Y [x]      | Y       |         | Y           | Y        | k_kex             |       |
| Kkcoin            | Y       | Y [x]      | Y       |         | Y           | Y        | kkcoin            |       |
| Koinex            | Y       |            |         |         | Y           |          | koinex            |       |
| Koinok            | Y       |            |         |         | Y           | Y        | koinok            |       |
| Koinx             | Y       | Y [x]      |         |         | Y           | Y        | koinx             |       |
| Korbit            | Y       | Y [x]      |         |         | User-Defined| Y        | korbit            |       |
| Kraken            | Y       | Y [x]      |         |         | Y           | Y        | kraken            |       |
| Kryptono          | Y       | Y [x]      | Y       |         | User-Defined| Y        | kryptono          |       |
| Kucoin            | Y       | Y [x]      | N       |         | Y           | Y        | kucoin            |       |
| Kuna              | Y       | Y [x]      | Y       |         | User-Defined| Y        | kuna              |       |
| KyberNetwork      | Y       | N          | N       |         | Y           | Y        | kyber_network     |       |
| LakeBTC           | Y       |            |         |         | Y           | Y        | lakebtc           |       |
| Latoken           | Y       |            |         |         | Y           | Y        | latoken           |       |
| Lbank             | Y       | Y [x]      | Y       |         | Y           | Y        | lbank             |       |
| Letsdocoinz       | Y       |            |         |         | Y           |          | letsdocoinz       |       |
| Liqui             | Y       |            |         |         | Y           |          | liqui             |       |
| LiteBit.eu        | Y       |            |         |         | Y           |          | litebiteu         |       |
| Livecoin          | Y       |            |         |         | Y           |          | livecoin          |       |
| LocalTrade        | Y       |            |         |         | Y           | Y        | localtrade        |       |
| Luno              | Y       |            |         |         | Y           | Y        | luno              |       |
| Lykke             | Y       | Y          | N       |         | Y           |          | lykke             |       |
| Maplechange       | Y       | Y          |         |         | Y           | Y        | maplechange       |       |
| MaxMaicoin        | Y       | Y [x]      | Y       |         | Y           | Y        | max_maicoin       |       |
| MercadoBitcoin    | Y       |            |         |         | User-Defined|          | mercado_bitcoin   |       |
| Mercatox          | Y       | N          | N       | N       | Y           |          | mercatox          |       |
| MXC               | Y       | Y [x]      |         |         | Y           | Y        | mxc               |       |
| Myspeedtrade      | Y       | Y          |         |         | Y           |          | myspeedtrade      |       |
| Nanex             | Y       | N          | N       | N       | Y           |          | nanex             |       |
| Nanu.Exchange     | Y       | Y          | Y       |         | Y           |          | nanu_exchange     |       |
| Nebula            | Y       | N          | Y       |         | Y           |          | nebula            |       |
| Negociecoins      | Y       | Y [x]      | Y       |         | User-Defined|          | negociecoins      |       |
| Neraex            | Y       | Y          | Y       |         | Y           | Y        | neraex            |       |
| Newdex            | Y       | N          | N       |         | Y           | Y        | newdex            |       |
| Nexybit           | Y       | Y          | N       |         | Y           | N        | nexybit           |       |
| Ninecoin (Halted) | Y       |            |         |         | Y           |          | ninecoin          |       |
| NLexch            | Y       |            |         |         | Y           | Y        | nlexch            |       |
| Novadex           | Y       | N          | N       |         | Y           | Y        | novadex           |       |
| Novadax           | Y       | N          | Y       |         | User-Defined| N        | novadax           |       |
| Nusax             | Y       |            |         |         | Y           | Y        | nusax             |       |
| Nova Exchange     | Y       |            |         |         | Y           |          | novaexchange      |       |
| OasisDEX          | Y       |            |         |         | Y           |          | oasisdex          |       |
| OAX               | Y       |            |         |         | Y           |          | oax               |       |
| Oceanex           | Y       | Y          | Y       |         | Y           | Y        | oceanex           |       |
| Octaex            | Y       | Y          | Y       |         | Y           |          | octaex            |       |
| OEX               | Y       | Y [x]      |         |         | Y           |          | oex               |       |
| OKCoin            | Y       |            |         |         | User-Defined|          | okcoin            |       |
| OKEx              | Y       | Y [x]      | Y       |         | Y           | Y        | okex              |       |
| OKEx Perpetual Swaps | Y (no volume) | Y (can't map) |         |         | Y           | Y        | okex_swap         |futures|
| Omgfin            | Y       | Y [x]      |         |         | Y           | Y        | omgfin            |       |
| OmniTrade         | Y       | Y          | Y       | Y       | Y           |          | omnitrade         |       |
| Ooobtc            | Y       | Y [x]      | Y       |         | Y           | Y        | ooobtc            |       |
| Openledger        | Y       | Y          | Y       |         | Y           | Y        | openledger        |       |
| OrderBook         | Y       | Y          | Y       |         | Y           | Y        | orderbook         |       |
| Ore Bz            | Y       | Y          | Y       |         | Y           | Y        | ore_bz            |       |
| OTCBTC            | Y       | Y          | Y       |         | Y           |          | otcbtc            |       |
| P2pb2b            | Y       | Y [x]      | Y       |         | Y           |          | p2pb2b            |       |
| Paribu            | Y       |            |         |         | Y           |          | paribu            |       |
| Paro Exchange     | Y       |            |         |         | Y           |          | paroexchange      |       |
| Paymium           | Y       | Y          | Y       |         | User-Defined|          | paymium           |       |
| Poloniex          | Y       | Y [x]      |         |         | Y           | Y        | poloniex          |       |
| Purcow            | Y       |            |         |         | Y           | Y        | purcow            |       |
| QBTC              | Y       | Y          | Y       |         | Y           |          | qbtc              |       |
| Qryptos           | Y       |            |         |         | Y           |          | qryptos           |       |
| Qtrade            | Y       | Y [x]      |         |         | Y           |          | qtrade            |       |
| QuadrigaCX        | Y       |            |         |         | User-Defined|          | quadrigacx        |       |
| Liquid (Quoine)   | Y       | Y [x]      |         |         | Y           | Y        | quoine            |       |
| RadarRelay        | Y       | Y [x]      |[No Price]|         | Y           | Y        | radar_relay      |       |
| Raisex            | Y       |            |         |         | Y           |          | raisex            |       |
| Rfinex            | Y       | Y          | Y       |         | Y           |          | rfinex            |       |
| RightBTC          | Y       | Y [x]      | Y       |         | Y           |          | rightbtc          |       |
| SafeTrade         | Y       | N          | N       |         | Y           |          | safe_trade        |       |
| SaturnNetwork     | Y       |            |         |         | Y           | Y        | saturn_network    |       |
| Secondbtc         | Y       | N          | N       |         | Y           | Y        | secondbtc         |       |
| Shortex           | Y       | Y [x]      |         |         | Y           | Y        | shortex           |       |
| Sigen             | Y       |            |         |         | Y           | Y        | sigen             |       |
| Simex             | Y       | N          | N       |         | Y           | Y        | simex             |       |
| Singularx         | Y       | N          | N       |         | Y           |          | singularx         |       |
| Sistemkoin        | Y       |            |         |         | Y           |          | sistemkoin        |       |
| 6X                | Y       | Y [x]      |         |         | Y           | Y        | six_x             |       |
| Satang (Tdax)     | Y       |            |         |         | Y           | Y        | tdax              |       |
| SouthXchange      | Y       | Y [x]      | Y       |         | Y           | Y        | south_xchange     |       |
| Stocks Exchange   | Y       |            |         |         | Y           | Y        | stocks_exchange   |       |
| Swiftex           | Y       | Y          |         |         | Y           | Y        | swiftex           |       |
| Switcheo          | Y       | Y [x]      | N       |         | Y           | Y        | switcheo          |       |
| Syex              | Y       | N          | N       |         | Y           | Y        | syex              |       |
| SZZC              | Y       |            |         |         | Y           |          | szzc              |       |
| Tdax              | Y       | N          | N       |         | Y           | Y        | tdax              |       |
| The Rock Trading  | Y       | Y [x]      | Y       |         | Y           | Y        | therocktrading    |       |
| The Token Store   | Y       | Y          | Y       |         | Y           | Y        | thetokenstore     |       |
| Thinkbit          | Y       | Y          | Y       |         | Y           |          | thinkbit          |       |
| 3Xbit             | Y       | Y          | Y       |         | Y           | Y        | three_xbit        |       |
| Tideal            | Y       | Y          | Y       |         | Y           |          | tideal            |       |
| Tidebit           | Y       | Y [x]      | Y       |         | Y           |          | tidebit           |       |
| Tidex             | Y       |            |         |         | Y           |          | tidex             |       |
| Tokenize          | Y       |            |         |         | Y           | Y        | tokenize          |       |
| Tokenjar          | Y       |            |         |         | Y           |          | tokenjar          |       |
| Tokenomy          | Y       | Y [x]      | Y       |         | Y           | Y        | tokenomy          |       |
| TokensNet         | Y       | Y          | Y       |         | Y           | N        | tokens_net        |       |
| Tokok             | Y       | Y [x]      | Y       |         | Y           |          | tokok             |       |
| Topbtc            | Y       | N          | N       |         | Y           | Y        | topbtc            |       |
| TradeOgre         | Y       | Y [x]      | Y       |         | Y           | Y        | trade_ogre        |       |
| Trade Satoshi     | Y       | Y [x]      |         |         | Y           | Y        | trade_satoshi     |       |
| Trade.io          | Y       |            |         |         | Y           |          | tradeio           |       |
| Trade.mn          | Y       | Y [x]      | Y       |         | Y           |          | trademn           |       |
| TrocaNinja        | Y       | N          | N       |         | Y           |          | troca_ninja       |       |
| TronTrade         | Y       | N          | N       |         | Y           |          | tron_trade        |       |
| TrustDex **       | Y       |            |         |         | Y           |          | trust_dex         |       |
| TuxExchange       | Y       |            |         |         | Y           |          | tux_exchange      |       |
| TRXMarket         | Y       |            |         |         | Y           |          | trx_market        |       |
| Txbit             | Y       | Y [x]      |         |         | Y           | Y        | txbit             |       |
| UEX               | Y       |            |         |         | Y           |          | uex               |       |
| Unidax            | Y       | N          | N       |         | Y           | N        | unidax            |       |
| Uniswap           | Y       | N          | N       |         | Y           | N        | uniswap           |       |
| Unocoin           |         |            |         |         |             |          | unocoin           |       |
| Upbit             | Y       | Y [x]      | Y       |         | Y           | Y        | upbit             |       |
| Vaultmex          | Y       | Y          | Y       |         | Y           | Y        | vaultmex          |       |
| Vbitex            | Y       | N          | N       |         | Y           | Y        | vbitex            |       |
| Vebitcoin         | Y       | N          | N       |         | Y           | N        | vebitcoin         |       |
| Velic             | Y       |            |         |         | Y           | N        | velic             |       |
| Vertpig           | Y       | Y          | N       |         | Y           | Y        | vertpig           |       |
| Viabtc            | Y       |            |         |         | User-Defined|          | viabtc            |       |
| Vindax            | Y       |            |         |         | Y           | Y        | vindax            |       |
| Vinex             | Y       | Y [x]      |         |         | Y           | Y        | vinex             |       |
| Waves             | Y       | N          | Y       |         | Y           |          | waves             |       |
| WazirX            | Y       |            |         |         | Y           |          | wazirx            |       |
| Wcx               | Y       | Y          | Y       |         | Y           |          | wcx               |       |
| Wex               | Y       | Y          | Y       |         | Y           | Y        | wex               |       |
| Worldcore         | Y       | Y          | Y       |         | Y           | Y        | worldcore         |       |
| Xt                | Y       | Y [x]      | Y       |         | Y           | Y        | xt                |       |
| Yobit             | Y       |            |         |         | Y           | Y        | yobit             |       |
| Yuanbao           | Y       |            |         |         | User-Defined|          | yuanbao           |       |
| Yunbi             | Y       |            |         |         | Y           |          | yunbi             |       |
| Zaif              | Y       | Y [x]      | Y       |         | Y           | Y        | zaif              |       |
| ZB                | Y       | Y [x]      | Y       |         | Y           | Y        | zb                |       |
| ZBG               | Y       | Y [x]      | Y       |         | Y           |          | zbg               |       |
| Zbmega            | Y       | N          | N       |         | Y           | Y        | zbmega            |       |
| Zebpay            | Y       |            |         |         | Y           |          | Zebpay            |       |
| Zeniex            | Y       | Y          | Y       |         | Y           |          | zeniex            |       |
| ZG                | Y       | Y [x]      | Y       |         | Y           | Y        | zg                |       |
| ZG.TOP            | Y       |            |         |         | Y           |          | zgtop             |       |

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

### Query the Ticker stream API

```
  pair = client.pairs('bitfinex').first
  thread = client.ticker_stream(
    market_pair: pair,
    onopen: Proc.new { puts 'Opened!' },
    onmessage: Proc.new do |ticker|
                 puts ticker.base
                 puts ticker.target
                 puts ticker.last
                 # ...
               end,
    onclose: Proc.new { puts 'Closed!' },
  )

  thread.kill
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

### Query the OrderBook stream API

```
  pair = client.pairs('bitfinex').first
  thread = client.order_book_stream(
    market_pair: pair,
    onopen: Proc.new { puts 'Opened!' },
    onmessage: Proc.new do |order_book|
                 puts order_book.asks[0].price if order_book.asks[0]
                 puts order_book.bids[0].price if order_book.bids[0]
                 # ...
               end,
    onclose: Proc.new { puts 'Closed!' },
  )

  thread.kill
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

### Query the Trade stream API

```
  pair = client.pairs('bitfinex').first
  thread = client.trade_stream(
    market_pair: pair,
    onopen: Proc.new { puts 'Opened!' },
    onmessage: Proc.new do |trade|
                 puts trade.trade_id
                 puts trade.price
                 puts trade.amount
                 # ...
               end,
    onclose: Proc.new { puts 'Closed!' },
  )

  thread.kill
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

### configuration (cache)

This gem uses https://github.com/SamSaffron/lru_redux cache by default so it doesn't hit exchanges with endpoint that returns multiple tickers for each ticker you are querying.

Alternatively, if you are using rails you can use rails cache (ActiveSupport::Cache::Store) by changing the config:
create the following file `/config/initializers/cryptoexchange.rb` and have the config inside.

```
Cryptoexchange.configure do |config|
  config.ticker_ttl = 10
  # ticker cache duration in seconds
  # default value = 10

  config.cache_size = 200
  # lru_redux cache store, ONLY EFFECTIVE if you use lru_redux cache which is the default, this value will be ignored when using rails cache
  # default value = 200

  config.rails_cache = false
  # enables rails cache
  # default value = false
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/coingecko/cryptoexchange. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

When implementing a new exchange for HTTP API, refer to this [guide](https://github.com/coingecko/cryptoexchange/wiki/Implementing-a-New-Exchange-(HTTP-API)).
For Websocket API, refer to this [guide](https://github.com/coingecko/cryptoexchange/wiki/Implementing-a-New-Exchange-(Websocket-API))

The [contributing guide](https://github.com/coingecko/cryptoexchange/blob/master/CONTRIBUTING.md) may also be useful to you.

You can chat with the core team member or other participating in this repository chat on [https://gitter.im/cryptoexchange-api/Lobby/~chat#](https://gitter.im/cryptoexchange-api/Lobby/~chat#)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
