module Cryptoexchange::Exchanges
  module Oceanex
    class Market < Cryptoexchange::Models::Market
      NAME    = 'oceanex'
      API_URL = 'https://api.oceanex.pro/v1'

      def self.trade_page_url(args = {})
        base   = args[:base].downcase
        target = args[:target].downcase
        "https://oceanex.pro/trades/#{base}#{target}"
      end
    end
  end
end
