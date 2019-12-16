module Cryptoexchange::Exchanges
  module SafeTrade
    class Market < Cryptoexchange::Models::Market
      NAME    = 'safe_trade'
      API_URL = 'https://safe.trade/api/v2/peatio/public'

      def self.trade_page_url(args={})
        "https://safe.trade/trading/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
