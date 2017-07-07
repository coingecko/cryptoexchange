require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Korbit::Services::Pairs do
  it { expect(described_class::MARKET::NAME).to eq 'korbit' }
end
