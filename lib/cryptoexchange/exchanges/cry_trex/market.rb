module Cryptoexchange::Exchanges
  module CryTrex
    class Market < Cryptoexchange::Models::Market
      NAME = 'cry_trex'
      API_URL = 'https://crytrex.com/public_api'

      def self.trade_page_url(args={})
        "https://crytrex.com/markets"
      end
    end
  end
end
