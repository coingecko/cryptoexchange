require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Probit::Market do
  it { expect(described_class::NAME).to eq 'probit' }
  it { expect(described_class::API_URL).to eq 'https://api.probit.com/api/exchange/v1' }
end
