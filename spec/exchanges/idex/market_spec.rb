require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Idex::Market do
  it { expect(described_class::NAME).to eq 'idex' }
  it { expect(described_class::API_URL).to eq 'https://api.idex.market' }
end
