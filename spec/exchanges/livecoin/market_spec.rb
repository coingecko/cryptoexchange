require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Livecoin::Market do
  it { expect(described_class::NAME).to eq 'livecoin' }
  it { expect(described_class::API_URL).to eq 'https://api.livecoin.net' }
end
