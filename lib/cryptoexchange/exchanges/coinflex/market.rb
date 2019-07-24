module Cryptoexchange::Exchanges
  module Coinflex
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinflex'
      API_URL = 'https://webapi.coinflex.com'

      def self.trade_page_url(args={})
        "https://coinflex-preview.trade.tt/live/preview"
      end
    end
  end
end
