module Cryptoexchange::Exchanges
  module Deribit
    module Services
      module Options
        class Instruments < Cryptoexchange::Services::Options::Instruments
          def fetch
            btc_instruments = fetch_via_api("https://www.deribit.com/api/v2/public/get_instruments?currency=BTC&kind=option&expired=false")
            eth_instruments = fetch_via_api("https://www.deribit.com/api/v2/public/get_instruments?currency=ETH&kind=option&expired=false")
            adapt(btc_instruments["result"] + eth_instruments["result"])
          end

          def adapt(output)
            output.map do |pair|
              Cryptoexchange::Models::OptionInstrument.new(
                base: pair['base_currency'],
                target: pair['quote_currency'],
                market: Deribit::Market::NAME,
                inst_id: pair['instrument_name'],
                expire_at: pair['expiration_timestamp'],
                option_type: pair['option_type'], 
                strike: pair['strike'], 
                settlement_period: pair['settlement_period'],
              )
            end
          end
        end
      end
    end
  end
end
