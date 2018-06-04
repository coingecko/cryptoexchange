require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Stellarport::Market do
  it { expect(described_class::NAME).to eq 'stellarport' }
  it { expect(described_class::API_URL).to eq 'https://stellar.api.stellarport.io/Market/Top' }
end
