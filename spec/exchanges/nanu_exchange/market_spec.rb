require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::NanuExchange::Market do
  it { expect(described_class::NAME).to eq 'nanu_exchange' }
  it { expect(described_class::API_URL).to eq 'https://nanu.exchange/public?command' }
end
