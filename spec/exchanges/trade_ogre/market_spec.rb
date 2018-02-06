require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::TradeOgre::Market do
  it { expect(described_class::NAME).to eq 'trade_ogre' }
  it { expect(described_class::API_URL).to eq 'https://tradeogre.com/api/v1' }
end
