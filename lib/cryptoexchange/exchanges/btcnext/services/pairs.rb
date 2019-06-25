module Cryptoexchange::Exchanges
  module Btcnext
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Btcnext::Market::API_URL}/b2trade/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output.map do |pair|
            separator = /(BTC|USDT|ETH)\z/ =~ pair['Instrument']

            next if separator.nil?

            base   = pair['Instrument'][0..separator - 1]
            target = pair['Instrument'][separator..-1]

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Btcnext::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
