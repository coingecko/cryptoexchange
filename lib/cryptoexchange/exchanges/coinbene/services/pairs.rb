module Cryptoexchange::Exchanges
  module Coinbene
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinbene::Market::API_URL}/market/ticker?symbol=all"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['ticker'].map do |pair|
            separator = /(USDT|BTC|ETH|BITCNY)\z/ =~ pair['symbol']

            next if separator.nil?

            base   = pair['symbol'][0..separator - 1]
            target = pair['symbol'][separator..-1]
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: 'coinbene'
            )
          end.compact
        end
      end
    end
  end
end
