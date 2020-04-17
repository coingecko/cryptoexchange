require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitmartFutures::Market do
  it { expect(described_class::NAME).to eq 'bitmart_futures' }
  it { expect(described_class::API_URL).to eq 'https://api-cloud.bitmart.com/contract/v1' }
end
