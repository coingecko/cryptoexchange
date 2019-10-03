require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Unnamed::Market do
  it { expect(described_class::NAME).to eq 'unnamed' }
  it { expect(described_class::API_URL).to eq 'https://api.unnamed.exchange/v1/Public' }
end
