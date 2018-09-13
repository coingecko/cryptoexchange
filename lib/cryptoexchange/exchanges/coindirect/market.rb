module Cryptoexchange::Exchanges
  module Coindirect
    class Market < Cryptoexchange::Models::Market
      NAME    = 'coindirect'
      API_URL = 'https://api.coindirect.com/api/v1'

      def self.trade_page_url(args = {})
        base = args[:base].downcase
        target = args[:target].downcase
        "https://exchange.coindirect.com/#{base}-#{target}"
      end
    end
  end
end
