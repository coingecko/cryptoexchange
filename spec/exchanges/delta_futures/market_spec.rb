require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::DeltaFutures::Market do
  it { expect(described_class::NAME).to eq 'delta_futures' }
  it { expect(described_class::API_URL).to eq 'https://api.delta.exchange' }
end
