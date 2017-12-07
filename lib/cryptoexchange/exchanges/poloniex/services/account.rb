module Cryptoexchange::Exchanges
  module Poloniex
    module Services
      class Account < Cryptoexchange::Services::Account
        def fetch(command)
          setup = config_setup
          key = setup[:key]
          secret = setup[:secret]
          nonce = (Time.now.to_f * 10000000).to_i
          params = {}
          params[:command] = command
          params[:nonce] = nonce
          output = super(self.ticker_url, {Key: key, Sign: create_sign(secret, params)}, params)
          adapt(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Poloniex::Market::API_TRADE_URL}"
        end

        private

        def create_sign(secret, params)
          encoded_data = Addressable::URI.form_encode(params)
          OpenSSL::HMAC.hexdigest('sha512', secret, encoded_data )
        end

        def adapt(output)
          account_list = []
          output.each do |currency, address|
            account_list << Cryptoexchange::Models::AccountInfo.new(
                              currency: currency,
                              address: address,
                              market: Poloniex::Market::NAME
                            )
          end
          account_list
        end
      end
    end
  end
end
