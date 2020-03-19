module Cryptoexchange::Exchanges
  module HuobiThailand
    class Market < Cryptoexchange::Models::Market
      NAME = 'huobi_thailand'
      API_URL = 'https://www.huobi.co.th/api'

      def self.trade_page_url(args = {})
        "https://www.huobi.co.th/th-th/exchange/#s=#{args[:base].downcase}_#{args[:target].downcase}"
      end

      def self.separate_symbol(pair)
        separator = /(|THB)\z/i =~ pair
        base      = pair[0..separator - 1]
        target    = pair[separator..-1]
        [base, target]
      rescue NoMethodError
        nil
      end
    end
  end
end
