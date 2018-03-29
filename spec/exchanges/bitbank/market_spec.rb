require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitbank::Market do
  it { expect(described_class::NAME).to eq 'bitbank' }
  it { expect(described_class::API_URL).to eq 'https://public.bitbank.cc' }
end
