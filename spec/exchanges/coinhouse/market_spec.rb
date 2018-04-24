require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinhouse::Market do
  it { expect(described_class::NAME).to eq 'coinhouse' }
  it { expect(described_class::API_URL).to eq 'https://coinhouse.eu/v2' }
end
