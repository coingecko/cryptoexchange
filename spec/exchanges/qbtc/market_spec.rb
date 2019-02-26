require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Qbtc::Market do
  it { expect(described_class::NAME).to eq 'qbtc' }
  it { expect(described_class::API_URL).to eq 'https://www.qbtc.ink/json' }
end
