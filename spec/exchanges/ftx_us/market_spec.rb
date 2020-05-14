require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::FtxUs::Market do
  it { expect(described_class::NAME).to eq 'ftx_us' }
  it { expect(described_class::API_URL).to eq 'https://ftx.us/api' }
end
