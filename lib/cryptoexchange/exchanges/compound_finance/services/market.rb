module Cryptoexchange::Exchanges
  module CompoundFinance
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        HOURS_24 = 24*60*60

        def fetch
          last_24h_ctokens = super(last_24h_ctokens_url) 
          current_ctokens = super(ticker_url)
          adapt_all(current_ctokens, last_24h_ctokens)
        end

        def last_24h_ctokens_url
          "#{Cryptoexchange::Exchanges::CompoundFinance::Market::API_URL}/ctoken?meta=false&block_timestamp=#{Time.now.to_i - HOURS_24}"
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::CompoundFinance::Market::API_URL}/ctoken?meta=false"
        end

        def adapt_all(output, last_24h)
          output["cToken"].map do |ctoken|
            last_24h_token_stat = last_24h["cToken"].select do |last_24h_ctoken| 
              last_24h_ctoken["symbol"] == ctoken["symbol"] && last_24h_ctoken["underlying_symbol"] == ctoken["underlying_symbol"]
            end.first
            last_24h_token_volume = last_24h_token_stat["total_supply"]["value"].to_f
            adapt(ctoken, last_24h_token_volume)
          end
        end

        def adapt(output, last_24h_token_volume)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = output["symbol"]
          ticker.target    = output["underlying_symbol"]
          ticker.market    = CompoundFinance::Market::NAME
          ticker.last      = NumericHelper.to_d(output['exchange_rate']['value'])
          ticker.volume    = (output["total_supply"]["value"].to_f - last_24h_token_volume).abs
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
