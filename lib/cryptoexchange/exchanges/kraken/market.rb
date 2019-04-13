module Cryptoexchange::Exchanges
  module Kraken
    class Market < Cryptoexchange::Models::Market
      NAME = 'kraken'
      API_URL = 'https://api.kraken.com/0/public'

      def self.trade_page_url(args={})
        "https://trade.kraken.com/markets/kraken/#{args[:base].downcase}/#{args[:target].downcase}"
      end
    end
  end
end
