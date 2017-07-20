require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bithumb::Market do
  it { expect(described_class::NAME).to eq 'bithumb' }
  it { expect(described_class::API_URL).to eq 'https://api.bithumb.com' }
end
