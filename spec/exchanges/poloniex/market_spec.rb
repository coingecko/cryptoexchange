require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Poloniex::Market do
  it { expect(described_class::NAME).to eq 'poloniex' }
  it { expect(described_class::API_URL).to eq 'https://poloniex.com/public' }
end
