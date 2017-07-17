require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Gatecoin::Market do
  it { expect(described_class::NAME).to eq 'gatecoin' }
  it { expect(described_class::API_URL).to eq 'https://api.gatecoin.com' }
end
