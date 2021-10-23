require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Indoex::Market do
  it { expect(described_class::NAME).to eq 'indoex' }
  it { expect(described_class::API_URL).to eq 'https://api.indoex.io' }
end
