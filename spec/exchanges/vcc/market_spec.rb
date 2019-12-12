require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Vcc::Market do
  it { expect(described_class::NAME).to eq 'vcc' }
  it { expect(described_class::API_URL).to eq 'https://vcc.exchange/api/v2' }
end
