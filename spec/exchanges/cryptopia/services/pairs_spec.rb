require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cryptopia::Services::Pairs do
  it { expect(described_class::MARKET::NAME).to eq 'cryptopia' }
end
