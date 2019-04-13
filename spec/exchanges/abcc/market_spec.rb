require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Abcc::Market do
  it { expect(described_class::NAME).to eq 'abcc' }
  it { expect(described_class::API_URL).to eq 'https://api.abcc.com/api/v2' }

  describe 'with the string of a pair' do
    it 'can separate to base and target' do
      expect(described_class.separate_symbol('LTCBTC')).to match_array(['LTC', 'BTC'])
    end
  end
end
