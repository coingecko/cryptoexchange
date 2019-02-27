module Cryptoexchange::Exchanges
  module Codex
    class Market < Cryptoexchange::Models::Market
      NAME = 'codex'
      API_URL = 'https://api.codex.one'

      def self.trade_page_url(args={})
        "https://codex.one/exchange/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
