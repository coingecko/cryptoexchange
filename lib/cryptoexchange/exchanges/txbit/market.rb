module Cryptoexchange::Exchanges
  module Txbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'txbit'
      API_URL = 'https://api.txbit.io/api'

      def self.trade_page_url(args={})
        "https://txbit.io/Trade/#{args[:base].upcase}/#{args[:target].upcase}"
      end
    end
  end
end