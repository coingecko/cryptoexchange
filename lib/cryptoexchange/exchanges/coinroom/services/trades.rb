module Cryptoexchange::Exchanges
  module Coinroom
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          params = {}
          params['realCurrency'] = market_pair.target
          params['cryptoCurrency'] = market_pair.base
          output = fetch_using_post(ticker_url, params, true)
          #key values pair lies inside 'data'
          adapt(output["data"], market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Coinroom::Market::API_URL}/trades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Coinroom::Market::NAME
            tr.price     = trade['rate']
            tr.amount    = trade['amount']
            tr.timestamp = trade['date'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
