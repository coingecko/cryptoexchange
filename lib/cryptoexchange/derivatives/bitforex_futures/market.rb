module Cryptoexchange::Exchanges
  module BitforexFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitforex_futures'
      API_URL = 'https://bitforex.com/contract/mkapi'

      def self.trade_page_url(args={})
        "https://www.bitforex.com/en/perpetual/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
