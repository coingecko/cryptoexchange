require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Trademn::Market do
  it { expect(described_class::NAME).to eq 'trademn' }
  it { expect(described_class::API_URL).to eq 'https://api.trade.mn/public' }
end
