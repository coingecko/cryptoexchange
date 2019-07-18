require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ftx::Market do
  it { expect(described_class::NAME).to eq 'ftx' }
  it { expect(described_class::API_URL).to eq 'https://ftx.com/api' }
end
