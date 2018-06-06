require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cfinex::Market do
  it { expect(described_class::NAME).to eq 'cfinex' }
  it { expect(described_class::API_URL).to eq 'https://cfinex.com/api' }
end
