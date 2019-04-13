require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bw::Market do
  it { expect(described_class::NAME).to eq 'bw' }
  it { expect(described_class::API_URL).to eq 'https://www.bw.com/exchange/config/controller' }
end
