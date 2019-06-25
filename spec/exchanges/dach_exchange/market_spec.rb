require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::DachExchange::Market do
  it { expect(described_class::NAME).to eq 'dach_exchange' }
  it { expect(described_class::API_URL).to eq 'https://dach.exchange/api/public' }
end
