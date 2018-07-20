require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitforex::Market do
  it { expect(described_class::NAME).to eq 'bitforex' }
  it { expect(described_class::API_URL).to eq 'https://www.bitforex.com/server' }
end
