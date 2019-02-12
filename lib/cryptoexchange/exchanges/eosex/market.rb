module Cryptoexchange::Exchanges
  module Eosex
    class Market < Cryptoexchange::Models::Market
      NAME='eosex'
      API_URL = 'https://api.eosex.com/exchange/tickers'

      def self.trade_page_url(args={})
        "https://eosex.com/#/exchange/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
