module Cryptoexchange::Exchanges
  module TokensNet
    class Market < Cryptoexchange::Models::Market
      NAME = 'tokens_net'
      API_URL = 'https://api.tokens.net'

      def self.trade_page_url(args={})
        "https://www.tokens.net/trading-pair/#{args[:base].downcase}#{args[:target].downcase}/"
      end
    end
  end
end
