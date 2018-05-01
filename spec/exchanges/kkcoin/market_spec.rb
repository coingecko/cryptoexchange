require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Kkcoin::Market do
  it { expect(described_class::NAME).to eq 'kkcoin' }
  it { expect(described_class::API_URL).to eq 'https://api.kkcoin.com/rest' }
end
