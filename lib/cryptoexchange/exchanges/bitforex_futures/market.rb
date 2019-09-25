module Cryptoexchange::Exchanges
  module BitforexFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitforex_futures'
      API_URL = 'https://www.bitforex.com/contract/mkapi/v2/'

      def self.trade_page_url(args={})
        "https://www.bitforex.com/en/perpetual/#{args[:inst_id]}"
      end
    end
  end
end
