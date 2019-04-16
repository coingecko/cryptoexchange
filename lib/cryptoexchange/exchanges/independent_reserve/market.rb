module Cryptoexchange::Exchanges
  module IndependentReserve
    class Market < Cryptoexchange::Models::Market
      NAME    = 'independent_reserve'
      API_URL = 'https://api.independentreserve.com/Public'

      def self.trade_page_url(args = {})
        base = args[:base].downcase
        "https://www.independentreserve.com/market##{base}"
      end
    end
  end
end
