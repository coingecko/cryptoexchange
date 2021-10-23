require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitsharesAssets::Market do
  it { expect(described_class::NAME).to eq 'bitshares_assets' }
  it { expect(described_class::API_URL).to eq 'https://cryptofresh.com/api' }
end
