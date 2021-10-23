require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::GateFutures::Market do
  it { expect(described_class::NAME).to eq 'gate_futures' }
  it { expect(described_class::API_URL).to eq 'https://fx-api.gateio.ws/api/v4/futures' }
end
