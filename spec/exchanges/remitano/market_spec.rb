require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Remitano::Market do
  it { expect(described_class::NAME).to eq 'remitano' }
  it { expect(described_class::API_URL).to eq 'https://api.remitano.com/api/v1' }
end
