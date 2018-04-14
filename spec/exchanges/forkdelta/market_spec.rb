require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Forkdelta::Market do
  it { expect(described_class::NAME).to eq 'forkdelta' }
  it { expect(described_class::API_URL).to eq 'https://api.forkdelta.com' }
  it { expect(described_class::TOKEN_URL).to eq 'https://forkdelta.github.io/config/main.json' }

  it 'fetch symbol' do
    VCR.use_cassette('Forkdelta/fetch_symbol') do
      output = described_class.fetch_symbol
      expect(output).to_not be_nil
      expect(output.count).to be > 100
    end
  end
end
