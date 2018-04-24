require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Waves::Market do
  it { expect(described_class::NAME).to eq 'waves' }
  it { expect(described_class::API_URL).to eq 'https://marketdata.wavesplatform.com/api' }
end
