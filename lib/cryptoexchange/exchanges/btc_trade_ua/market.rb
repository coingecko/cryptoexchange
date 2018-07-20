module Cryptoexchange::Exchanges
  module BtcTradeUa
    class Market < Cryptoexchange::Models::Market
      NAME = 'btc_trade_ua'
      API_URL = 'https://btc-trade.com.ua/api'
    end
  end
end
