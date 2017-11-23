require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cex::Market do
  it { expect(described_class::NAME).to eq 'cex' }
  it { expect(described_class::API_URL).to eq 'https://cex.io/api' }
end
