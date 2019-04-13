module Cryptoexchange::Exchanges
  module Tidebit
    class Market < Cryptoexchange::Models::Market
      NAME = 'tidebit'
      API_URL = 'https://www.tidebit.com/api/v2'

      def self.trade_page_url(args={})
        "https://www.tidebit.com/markets/#{args[:base].downcase}#{args[:target].downcase}"
      end
    end
  end
end
