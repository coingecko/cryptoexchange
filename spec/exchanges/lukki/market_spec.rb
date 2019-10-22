require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Lukki::Market do
  it { expect(described_class::NAME).to eq 'lukki' }
  it { expect(described_class::API_URL).to eq 'https://tva.lukki.io' }
end
