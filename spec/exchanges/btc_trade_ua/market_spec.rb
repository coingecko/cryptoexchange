require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BtcTradeUa::Market do
  it { expect(described_class::NAME).to eq 'btc_trade_ua' }
  it { expect(described_class::API_URL).to eq 'https://btc-trade.com.ua/api' }
end
