require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Localtrade::Market do
  it { expect(described_class::NAME).to eq 'localtrade' }
  it { expect(described_class::API_URL).to eq 'https://localtrade.cc/main' }
end
