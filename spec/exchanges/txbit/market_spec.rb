require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Txbit::Market do
  it { expect(described_class::NAME).to eq 'txbit' }
  it { expect(described_class::API_URL).to eq 'https://api.txbit.io/api' }
end