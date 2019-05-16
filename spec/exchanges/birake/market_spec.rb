require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Birake::Market do
  it { expect(described_class::NAME).to eq 'birake' }
  it { expect(described_class::API_URL).to eq 'https://api.birake.com' }
end
