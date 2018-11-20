require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Kineticex::Market do
  it { expect(described_class::NAME).to eq 'kineticex' }
  it { expect(described_class::API_URL).to eq 'https://ttlivewebapi.kineticex.com:8443/api/v1/public' }
end
