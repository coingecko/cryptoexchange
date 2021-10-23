require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Resfinex::Market do
  it { expect(described_class::NAME).to eq 'resfinex' }
  it { expect(described_class::API_URL).to eq 'https://api.resfinex.com/engine' }
end
