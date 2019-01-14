require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Tokenmom::Market do
  it { expect(described_class::NAME).to eq 'tokenmom' }
  it { expect(described_class::API_URL).to eq 'https://api.tokenmom.com' }
end
