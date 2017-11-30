require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::LocalBitcoins::Market do
  it { expect(described_class::NAME).to eq 'local_bitcoins' }
  it { expect(described_class::API_URL).to eq 'https://localbitcoins.com' }
end
