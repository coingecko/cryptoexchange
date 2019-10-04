module Cryptoexchange::Exchanges
  module PrimeXbt
    class Market < Cryptoexchange::Models::Market
      NAME = 'prime_xbt'
      API_URL = 'https://api.primexbt.com/v1'

      def self.trade_page_url(args={})
        "https://web.primexbt.com/"
      end
    end

  end
end
