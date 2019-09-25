require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Deribit::Market do
  it { expect(described_class::NAME).to eq 'deribit' }
  it { expect(described_class::API_URL).to eq 'https://www.deribit.com/api/v2/public' }
end
