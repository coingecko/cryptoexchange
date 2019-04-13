module Cryptoexchange::Exchanges
  module Fubt
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Fubt::Market::API_URL}/market/tickers?accessKey=#{Cryptoexchange::Exchanges::Fubt::Market::ACCESS_KEY}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            pair_name = pair['tradeName']
            next if pair_name.nil?

            separator = Cryptoexchange::Exchanges::Coinex::Market::SEPARATOR_REGEX =~ pair_name.upcase
            next unless separator

            base = pair_name[0..separator - 1]
            target = pair_name[separator..-1]
            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Fubt::Market::NAME
            })
          end.compact
        end

      end
    end
  end
end
