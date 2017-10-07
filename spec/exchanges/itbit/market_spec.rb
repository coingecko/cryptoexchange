require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Itbit::Market do
  it { expect(described_class::NAME).to eq 'itbit' }
  it { expect(described_class::API_URL).to eq 'https://api.itbit.com/v1' }
end
