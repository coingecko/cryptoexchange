require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitflyer::Services::Pairs do
  it { expect(described_class::MARKET::NAME).to eq 'bitflyer' }
end
