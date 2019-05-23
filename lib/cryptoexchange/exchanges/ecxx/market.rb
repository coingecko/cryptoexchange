module Cryptoexchange::Exchanges
  module Ecxx
    class Market < Cryptoexchange::Models::Market
      NAME    = 'ecxx'
      API_URL = 'https://www.ecxx.com/exapi/api/v1'

      def self.trade_page_url(args = {})
        base   = args[:base].downcase
        target = args[:target].downcase
        "https://www.ecxx.com/tradingview?symbol=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
