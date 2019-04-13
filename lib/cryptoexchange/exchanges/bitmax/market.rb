module Cryptoexchange::Exchanges
  module Bitmax
    class Market
      NAME    = 'bitmax'
      API_URL = 'https://bitmax.io/api/v1'

      def self.trade_page_url(args = {})
        base   = args[:base].downcase
        target = args[:target].downcase
        "https://bitmax.io/#/trade/#{target}/#{base}"
      end
    end
  end
end
