module Cryptoexchange::Exchanges
  module Bitexbook
    class Market < Cryptoexchange::Models::Market
      NAME    = 'bitexbook'
      API_URL = 'https://api.bitexbook.com/api/v2'

      def self.trade_page_url(args = {})
        base   = args[:base].downcase
        target = args[:target].downcase
        "https://bitexbook.com/trading/#{base}#{target}"
      end
    end
  end
end
