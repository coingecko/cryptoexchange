require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Mercatox::Market do
  it { expect(described_class::NAME).to eq 'mercatox' }
  it { expect(described_class::API_URL).to eq 'https://mercatox.com/public' }
end
