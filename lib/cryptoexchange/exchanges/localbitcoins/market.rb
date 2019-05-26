module Cryptoexchange::Exchanges
  module Localbitcoins
    class Market < Cryptoexchange::Models::Market
      NAME = 'localbitcoins'
      API_URL = 'https://localbitcoins.com'

      def self.trade_page_url(args={})
        "https://localbitcoins.com"
      end
    end
  end
end
