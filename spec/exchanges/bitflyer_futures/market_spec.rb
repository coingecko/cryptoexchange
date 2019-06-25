require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitflyerFutures::Market do
  it { expect(described_class::NAME).to eq 'bitflyer_futures' }
  it { expect(described_class::API_URL).to eq 'https://api.bitflyer.com/v1' }
end
