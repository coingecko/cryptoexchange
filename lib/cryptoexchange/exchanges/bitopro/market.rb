module Cryptoexchange::Exchanges
  module Bitopro
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitopro'
      API_URL = 'https://api.bitopro.com/v2'

      def self.trade_page_url(args={})
        base = args[:base].downcase
        target = args[:target].downcase
        "https://www.bitopro.com/trading/#{base}_#{target}"
      end
    end
  end
end
