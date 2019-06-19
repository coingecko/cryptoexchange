module Cryptoexchange::Exchanges
  module StakeCube
    class Market < Cryptoexchange::Models::Market
      NAME = 'stake_cube'
      API_URL = 'https://stakecube.net/api/v1'

      def self.trade_page_url(args={})
        "https://stakecube.net/exchange/#{args[:target]}-#{args[:base]}"
      end
    end
  end
end
