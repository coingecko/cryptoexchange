module Cryptoexchange::Exchanges
  module NewCapital
    class Market < Cryptoexchange::Models::Market
      NAME = 'new_capital'
      API_URL = 'https://api.new.capital/v1'

      def self.trade_page_url(args = {})
        "https://new.capital/exchange/trade/#{args[:base].upcase}_#{args[:target].upcase}"
      end

    end
  end
end
