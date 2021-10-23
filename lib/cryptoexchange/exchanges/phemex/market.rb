module Cryptoexchange::Exchanges
  module Phemex
    class Market < Cryptoexchange::Models::Market
      NAME = 'phemex'
      API_URL = 'https://api.phemex.com/v1/md'

      def self.trade_page_url(args={})
        "https://phemex.com/trade/#{args[:inst_id]}"
      end

      def self.separate_symbol(pair)
        separator = /(|USD)\z/i =~ pair
        base      = pair[0..separator - 1]
        target    = pair[separator..-1]
        [base, target]
      rescue NoMethodError
        nil
      end
    end
  end
end
