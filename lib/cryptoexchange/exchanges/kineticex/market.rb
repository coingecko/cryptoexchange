module Cryptoexchange::Exchanges
  module Kineticex
    class Market < Cryptoexchange::Models::Market
      NAME    = 'kineticex'
      API_URL = 'https://ttlivewebapi.kineticex.com:8443/api/v1/public'

      def self.trade_page_url(args = {})
        base   = args[:base].downcase
        target = args[:target].downcase
        "https://exchange.kineticex.com/#{base}#{target}?type=exchange"
      end
    end
  end
end
