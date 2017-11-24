require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cex::Services::Pairs do
  it { expect(described_class::PAIRS_URL).to eq 'https://cex.io/api/currency_limits' }
end
