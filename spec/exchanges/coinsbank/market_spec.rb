require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinsbank::Market do
  it { expect(described_class::NAME).to eq 'coinsbank' }
  it { expect(described_class::API_URL).to eq 'https://coinsbank.com/sapi' }
end
