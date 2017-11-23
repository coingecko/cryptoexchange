require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitconnect::Services::Pairs do
  it { expect(described_class::PAIRS_URL).to eq 'https://bitconnect.co/api/info' }
end
