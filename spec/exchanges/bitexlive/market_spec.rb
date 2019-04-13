require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitexlive::Market do
  it { expect(described_class::NAME).to eq 'bitexlive' }
  it { expect(described_class::API_URL).to eq 'https://bitexlive.com/api' }
end
