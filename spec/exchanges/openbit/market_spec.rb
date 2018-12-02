require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Openbit::Market do
  it { expect(described_class::NAME).to eq 'openbit' }
  it { expect(described_class::API_URL).to eq 'https://market.openbit.online' }
end
