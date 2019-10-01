module Cryptoexchange::Exchanges
  module Bybit
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Bybit::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output["result"].map do |pair|
            separator = /(BTC|ETH|EOS|XRP|USD)\z/ =~ pair['symbol']
            next if separator.nil?

            base   = pair['symbol'][0..separator - 1]
            target = pair['symbol'][separator..-1]
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bybit::Market::NAME
            )

            adapt(market_pair, pair)
          end.compact
        end

        def adapt(market_pair, pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = Bybit::Market::NAME
          contract_stat.open_interest = pair['open_interest'].to_f
          contract_stat.index     = pair['index_price'].to_f

          contract_stat.payload   = pair
          contract_stat.expire_timestamp = nil
          contract_stat.start_timestamp = nil
          contract_stat.contract_type = "perpetual"

          contract_stat.funding_rate_percentage = pair['funding_rate'] ? pair['funding_rate'].to_f * 100 : nil
          contract_stat.next_funding_rate_timestamp = pair['next_funding_time'] ? DateTime.parse(pair['next_funding_time']).to_time.to_i : nil
          contract_stat.funding_rate_percentage_predicted = pair['predicted_funding_rate'] ? pair['predicted_funding_rate'].to_f * 100 : nil

          contract_stat
        end

        def contract_type(start, expire)
          if expire.nil?
            "perpetual"
          else
            "futures"
          end
        end
      end
    end
  end
end
