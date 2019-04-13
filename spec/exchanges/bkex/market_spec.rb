require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bkex::Market do
  it { expect(described_class::NAME).to eq 'bkex' }
  it { expect(described_class::API_URL).to eq 'https://www.bkex.com/api' }
end
