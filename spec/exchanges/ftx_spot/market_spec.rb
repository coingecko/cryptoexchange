require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::FtxSpot::Market do
  it { expect(described_class::NAME).to eq 'ftx_spot' }
  it { expect(described_class::API_URL).to eq 'https://ftx.com/api' }
end
