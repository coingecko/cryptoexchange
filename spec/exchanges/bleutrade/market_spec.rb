require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bleutrade::Market do
  it { expect(described_class::NAME).to eq 'bleutrade' }
  it { expect(described_class::API_URL).to eq 'https://bleutrade.com/api/v2' }
end
