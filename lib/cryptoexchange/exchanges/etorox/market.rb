module Cryptoexchange::Exchanges
  module Etorox
    class Market < Cryptoexchange::Models::Market
      NAME = 'etorox'
      API_URL = 'https://services.etorox.com/api/v1/marketdata/instruments'

      def self.trade_page_url(args={})
        "https://www.etorox.com/exchange/#{args[:base].downcase}-#{args[:target].downcase}"
      end

      def self.separate_symbol(pair)
        separator = /(EOS|BNB|USDT|USDC|SGDX|HKDX|ZARX|PLNX|TRYX|XLM|ETH|BTC|CNYX|RUBX|SLVRX|CADX|USDEX|CHFX|XRP|GBPX|NZDX|LTC|JPYX|GOLDX|EURX|DASH|BCH|AUDX|BTC)\z/i =~ pair
        base      = pair[0..separator - 1]
        target    = pair[separator..-1]
        [base, target]
      rescue NoMethodError
        nil
      end
    end
  end
end
