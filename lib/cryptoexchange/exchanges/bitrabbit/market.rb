module Cryptoexchange::Exchanges
  module Bitrabbit
    class Market < Cryptoexchange::Models::Market
      NAME    = 'bitrabbit'
      API_URL = 'https://bitrabbit.com/web'

      def self.trade_page_url(args = {})
        base   = args[:base].downcase
        target = args[:target].downcase
        "https://bitrabbit.com/markets/#{base}_#{target}"
      end
    end
  end
end
