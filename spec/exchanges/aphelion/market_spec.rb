require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Aphelion::Market do
  it { expect(described_class::NAME).to eq 'aphelion' }
  it { expect(described_class::API_URL).to eq 'http://mainnet.aphelion-neo.com:62433/api' }
end
