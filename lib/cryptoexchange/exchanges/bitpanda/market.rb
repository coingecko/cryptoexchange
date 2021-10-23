module Cryptoexchange::Exchanges
  module Bitpanda
    class Market < Cryptoexchange::Models::Market
      NAME    = 'bitpanda'
      API_URL = 'https://api.exchange.bitpanda.com/public/v1'

      def self.trade_page_url(args = {})
        base   = args[:base].upcase
        target = args[:target].upcase
        "https://exchange.bitpanda.com/#{base}_#{target}"
      end
    end
  end
end
