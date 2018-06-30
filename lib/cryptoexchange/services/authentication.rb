module Cryptoexchange::Services
  class Authentication
    def initialize(action, exchange)
      @action = action
      @exchange = exchange
    end

    def signature(payload:)
      raise NotImplementedError, 'signature method is not defined!'
    end

    def headers(payload:)
      raise NotImplementedError, 'header method is not defined!'
    end

    def validate_credentials!
      raise_credentials_missing_error if is_missing_credentials?
    end

    def is_missing_credentials?
      missing_credentials.length > 0
    end

    def missing_credentials
      credentials = Cryptoexchange::Credentials.get(@exchange).keys.map(&:to_sym)
      required_credentials.select do |required|
        !credentials.include?(required)
      end
    end

    def raise_credentials_missing_error
      raise Cryptoexchange::CredentialsMissingError, "#{missing_credentials.join(', ')} are required!"
    end

    def required_credentials
      # NOTE: For demonstration purposes
      case @action
      when :pairs, :market, :order_book, :trades
        []
      end
    end
  end
end
