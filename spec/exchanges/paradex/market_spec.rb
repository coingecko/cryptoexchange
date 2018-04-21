require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Paradex::Market do
  it { expect(described_class::NAME).to eq 'paradex' }
  it { expect(described_class::API_URL).to eq 'https://api.paradex.io/consumer' }

  it 'will raise error when there is no yml file' do
    expect {
      described_class.fetch_api_key(described_class.user_api_key_path)
    }.to raise_error(Cryptoexchange::ApiKeyMissingError)
  end
end
