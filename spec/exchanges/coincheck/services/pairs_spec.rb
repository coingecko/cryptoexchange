require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coincheck::Services::Pairs do
  it { expect(described_class::MARKET::NAME).to eq 'coincheck' }
end
