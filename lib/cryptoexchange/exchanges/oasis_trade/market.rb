module Cryptoexchange::Exchanges
  module OasisTrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'oasis_trade'
      API_URL = 'https://api.oasisdex.com/v2'

      def self.trade_page_url(args={})
        "https://oasis.app/trade/market/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
