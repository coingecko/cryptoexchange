require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Tidebit::Market do
  it { expect(described_class::NAME).to eq 'tidebit' }
  it { expect(described_class::API_URL).to eq 'https://www.tidebit.com/api/v2' }
end
