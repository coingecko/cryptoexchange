module Cryptoexchange::Exchanges
  module BambooRelay
    class Market < Cryptoexchange::Models::Market
      NAME = 'bamboo_relay'
      API_URL = 'https://rest.bamboorelay.com/main/0x'

      def self.trade_page_url(args={})
        "https://bamboorelay.com/trade/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
