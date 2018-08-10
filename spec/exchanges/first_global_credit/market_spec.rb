require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::FirstGlobalCredit::Market do
  it { expect(described_class::NAME).to eq 'first_global_credit' }
  it { expect(described_class::API_URL).to eq 'https://trading.firstglobalcredit.com/ticker' }
end
