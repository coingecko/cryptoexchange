require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Fex::Market do
  it { expect(described_class::NAME).to eq 'fex' }
  it { expect(described_class::API_URL).to eq 'http://api.fexpro.io/api' }
end
