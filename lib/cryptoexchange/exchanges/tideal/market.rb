module Cryptoexchange::Exchanges
  module Tideal
    class Market < Cryptoexchange::Models::Market
      NAME = 'tideal'
      API_URL = 'https://tideal.com/api/v2'
    
      def self.trade_page_url(args={})
        "https://tideal.com/markets/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
  