module Cryptoexchange::Exchanges
  module Coindcx
    class Market < Cryptoexchange::Models::Market
      NAME = 'coindcx'
      API_URL = 'https://api.coindcx.com'
      API_URL_2 = 'https://public.coindcx.com'

      def self.trade_page_url(args={})
        "https://coindcx.com/trade/#{args[:base]}#{args[:target]}"
      end

      def self.separate_symbol(pair)
        separator = /(|INR)\z/i =~ pair
        base      = pair[0..separator - 1]
        target    = pair[separator..-1]
        [base, target]
      rescue NoMethodError
        nil
      end
    end
  end
end
