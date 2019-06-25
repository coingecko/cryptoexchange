require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cezex::Market do
  it { expect(described_class::NAME).to eq 'cezex' }
  it { expect(described_class::API_URL).to eq 'https://beta.cezex.io/api/v2' }
end

