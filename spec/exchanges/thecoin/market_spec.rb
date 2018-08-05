require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Thecoin::Market do
  it { expect(described_class::NAME).to eq 'thecoin' }
  it { expect(described_class::API_URL).to eq 'https://trade.thecoin.pw/api/v1' }
end
