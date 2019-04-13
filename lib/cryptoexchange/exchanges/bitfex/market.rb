module Cryptoexchange::Exchanges
  module Bitfex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitfex'.freeze
      API_URL = 'https://bitfex.trade'.freeze

      def self.trade_page_url(args = {})
        "https://bitfex.trade/en/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
