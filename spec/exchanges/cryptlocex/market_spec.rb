require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cryptlocex::Market do
  it { expect(described_class::NAME).to eq 'cryptlocex' }
  it { expect(described_class::API_URL).to eq 'https://trade.cryptlocex.com/Api' }
end
