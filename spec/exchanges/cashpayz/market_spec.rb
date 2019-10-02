require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cashpayz::Market do
  it { expect(described_class::NAME).to eq 'cashpayz' }
  it { expect(described_class::API_URL).to eq 'https://cashpayz.exchange/public' }
end
