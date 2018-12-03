require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Tokenize::Market do
  it { expect(described_class::NAME).to eq 'tokenize' }
  it { expect(described_class::API_URL).to eq 'https://api2.tokenize.exchange/api' }
end
