module Cryptoexchange
  class ExchangeTemplate
    METHODS = [:market, :pairs, :tickers, :order_book, :trades, :market_spec, :integration_spec].freeze

    def initialize(identifier)
      @identifier = identifier
      @class_name = convert_identifier_to_class_name(identifier)
    end

    METHODS.each do |method|
      define_method method do
        render_template
        instance_variable_get "@#{method}"
      end
    end

    private

      def render_template
        @market = File.read("lib/cryptoexchange/templates/market.erb") % {class_name: @class_name, identifier: @identifier}
                    
        @pairs = File.read("lib/cryptoexchange/templates/pairs.erb") % {class_name: @class_name}
                   
        @tickers = File.read("lib/cryptoexchange/templates/tickers.erb") % {class_name: @class_name}

        @order_book = File.read("lib/cryptoexchange/templates/order_book.erb")  % {class_name: @class_name}
                         
        @trades = File.read("lib/cryptoexchange/templates/trades.erb") % {class_name: @class_name}

        @market_spec = File.read("lib/cryptoexchange/templates/market_spec.erb") % {class_name: @class_name, identifier: @identifier}

        @integration_spec = File.read("lib/cryptoexchange/templates/integration_spec.erb") % {class_name: @class_name, identifier: @identifier}
      end

      def convert_identifier_to_class_name(identifier)
        identifier.split('_').collect(&:capitalize).join
      end
  end
end
