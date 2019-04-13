module Cryptoexchange::Exchanges
  module Therocktrading
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Therocktrading::Market::API_URL}/funds/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['tickers'].map do |pair|
            separator = /(BTC|LTC|EUR|PPC|ETH|ZEC|BCH|NOKU|FDZ|GUSD|XRP|EURN)\z/ =~ pair['fund_id']

            next if separator.nil?

            base   = pair['fund_id'][0..separator - 1]
            target = pair['fund_id'][separator..-1]

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Therocktrading::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
