require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Hopex::Market do
  it { expect(described_class::NAME).to eq 'hopex' }
  it { expect(described_class::API_URL).to eq 'https://api2.hopex.com/api/v1' }
end
