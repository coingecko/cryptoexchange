require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitopro::Market do
  it { expect(described_class::NAME).to eq 'bitopro' }
  it { expect(described_class::API_URL).to eq 'https://api.bitopro.com/v2' }
end
