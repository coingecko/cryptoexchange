module Cryptoexchange::Exchanges
  module TrocaNinja
    class Market < Cryptoexchange::Models::Market
      NAME = 'troca_ninja'
      API_URL = 'https://troca.ninja/api'

      def self.trade_page_url(args={})
        "https://www.troca.ninja/markets/coin/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
