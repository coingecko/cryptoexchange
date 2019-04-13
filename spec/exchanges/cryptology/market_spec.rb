require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cryptology::Market do
  it { expect(described_class::NAME).to eq 'cryptology' }
  it { expect(described_class::API_URL).to eq 'https://api.prod.cryptology.com/public/v1' }
end
