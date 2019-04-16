require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::IndependentReserve::Market do
  it { expect(described_class::NAME).to eq 'independent_reserve' }
  it { expect(described_class::API_URL).to eq 'https://api.independentreserve.com/Public' }
end
