require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BtseFutures::Market do
  it { expect(described_class::NAME).to eq 'btse_futures' }
  it { expect(described_class::API_URL).to eq 'https://api.btse.com/futures/api/v1' }
end
