module Cryptoexchange::Exchanges
  module StakeCube
    class Market < Cryptoexchange::Models::Market
      NAME = 'stake_cube'
      API_URL = 'https://api.stakecube.net/v1'

      def self.trade_page_url(args={})
        "https://stakecube.net/app/exchange/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
