require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::GmoJapanFutures::Market do
  it { expect(described_class::NAME).to eq 'gmo_japan_futures' }
  it { expect(described_class::API_URL).to eq 'https://api.coin.z.com/public/v1' }
end
