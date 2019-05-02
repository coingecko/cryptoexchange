require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Qtrade::Market do
  it { expect(described_class::NAME).to eq 'qtrade' }
  it { expect(described_class::API_URL).to eq 'https://api.qtrade.io/v1' }
end
