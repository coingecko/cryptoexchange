module Cryptoexchange::Exchanges
  module Quoine
    class Market < Cryptoexchange::Models::Market
      NAME = 'quoine'
      API_URL = 'https://api.quoine.com'

      def self.trade_page_url(args={})
        "https://app.liquid.com/exchange/#{args[:base]}#{args[:target]}?lang=en"
      end
    end
  end
end
