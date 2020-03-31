require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitmaxFutures::Market do
  it { expect(described_class::NAME).to eq 'bitmax_futures' }
  it { expect(described_class::API_URL).to eq 'https://bitmax.io/api/pro/v1' }
end
