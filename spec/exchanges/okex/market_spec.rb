require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::OKEx::Market do
  it { expect(described_class::NAME).to eq 'okex' }
  it { expect(described_class::API_URL).to eq 'https://www.okex.com/api/v1' }
end
