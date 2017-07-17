require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cryptopia::Market do
  it { expect(described_class::NAME).to eq 'cryptopia' }
  it { expect(described_class::API_URL).to eq 'https://www.cryptopia.co.nz/api' }
end
