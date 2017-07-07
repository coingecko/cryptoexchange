require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Gatecoin::Services::Pairs do
  it { expect(described_class::MARKET::NAME).to eq 'gatecoin' }
end
