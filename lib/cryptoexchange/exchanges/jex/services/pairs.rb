module Cryptoexchange::Exchanges
  module Jex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Jex::Market::API_URL}"
        
        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.map do |pair, ticker|
            separator = /(CALL|PUT|ETF)/ =~ pair
            unless !separator.nil?
              base, target = pair.split('/')
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                base: base.upcase,
                target: target.upcase,
                market: Jex::Market::NAME
              )
            end
          end
          market_pairs
        end
      end
    end
  end
end
