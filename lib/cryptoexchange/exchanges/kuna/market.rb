module Cryptoexchange::Exchanges
  module Kuna
    class Market < Cryptoexchange::Models::Market
      NAME = 'kuna'
      API_URL = 'https://kuna.io/api/v2'

      def self.trade_page_url(args={})
        "https://kuna.io/markets/#{args[:base].downcase}#{args[:target].downcase}"
      end
    end
  end
end
