module Cryptoexchange::Exchanges
  module Prixbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'prixbit'
      API_URL = 'https://openapi.prixbit.com/openapi/v1'

      def self.trade_page_url(args={})
        "https://www.prixbit.com/exc/exchange.do?baseCrncyCd=#{args[:target]}&crncyCd=#{args[:base]}"
      end
    end
  end
end
