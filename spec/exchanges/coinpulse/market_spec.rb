require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinpulse::Market do
  it { expect(described_class::NAME).to eq 'coinpulse' }
  it { expect(described_class::API_URL).to eq 'http://coinpulse.io/api/v1' }
end
