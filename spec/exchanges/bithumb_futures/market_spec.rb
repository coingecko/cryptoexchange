require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BithumbFutures::Market do
  it { expect(described_class::NAME).to eq 'bithumb_futures' }
  it { expect(described_class::API_URL).to eq 'https://bithumbfutures.com/api/pro/v1' }
end
