require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinplace::Market do
  it { expect(described_class::NAME).to eq 'coinplace' }
  it { expect(described_class::API_URL).to eq 'https://coinplace.pro/share/ticker.json' }
end
