require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::StellarDex::Market do
  it { expect(described_class::NAME).to eq 'stellar_dex' }
  it { expect(described_class::API_URL).to eq 'https://api.stellarterm.com/v1' }
end
