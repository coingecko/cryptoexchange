module Cryptoexchange::Exchanges
  module KyberNetwork
    module Services
      class Market < Cryptoexchange::Services::Market
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
          "#{Cryptoexchange::Exchanges::KyberNetwork::Market::API_URL}/market"
        end

        def adapt_all(output)
          output = output["data"]
          tickers = []

          output.map do |pair|
            target, base = pair["quote_symbol"], pair["base_symbol"]
            ticker = Cryptoexchange::Models::Ticker.new
            ticker.base = base
            ticker.target = target
            ticker.market = KyberNetwork::Market::NAME

            ticker.last      = NumericHelper.to_d(pair['last_traded'])
            ticker.high      = NumericHelper.to_d(pair['past_24h_high'])
            ticker.low       = NumericHelper.to_d(pair['past_24h_low'])
            ticker.bid       = NumericHelper.to_d(pair['current_bid'])
            ticker.ask       = NumericHelper.to_d(pair['current_ask'])
            ticker.volume    = NumericHelper.divide(NumericHelper.to_d(pair['eth_24h_volume']), ticker.last)
            ticker.timestamp = nil
            ticker.payload   = pair

            tickers << ticker
          end

          tickers
        end
      end
    end
  end
end
