require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinut::Services::Pairs do
  it { expect(described_class.new.pairs_url).to eq 'https://api.coinut.com' }
end
