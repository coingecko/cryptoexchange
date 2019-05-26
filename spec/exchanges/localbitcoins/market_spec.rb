require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Localbitcoins::Market do
  it { expect(described_class::NAME).to eq 'localbitcoins' }
  it { expect(described_class::API_URL).to eq 'https://localbitcoins.com' }
end
