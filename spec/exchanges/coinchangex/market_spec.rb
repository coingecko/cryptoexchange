require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinchangex::Market do
  it { expect(described_class::NAME).to eq 'coinchangex' }
  it { expect(described_class::API_URL).to eq 'https://api.coinchangex.com' }
  it { expect(described_class::TOKEN_URL).to eq 'https://www.coinchangex.com/config/main.json' }

  it 'fetch symbol' do
    VCR.use_cassette('coinchangex/fetch_symbol') do
      output = described_class.fetch_symbol
      expect(output).to_not be_nil
      expect(output.count).to be > 20
    end
  end
end
