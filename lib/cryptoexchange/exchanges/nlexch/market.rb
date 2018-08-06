module Cryptoexchange::Exchanges
  module Nlexch
    class Market < Cryptoexchange::Models::Market
      NAME = 'nlexch'
      API_URL = 'https://www.nlexch.com/api/v2'

      def self.trade_page_url(args={})
        "https://www.nlexch.com/markets/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
