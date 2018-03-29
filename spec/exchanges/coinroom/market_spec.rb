require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinroom::Market do
  it { expect(described_class::NAME).to eq 'coinroom' }
  it { expect(described_class::API_URL).to eq 'https://coinroom.com/api' }
end
