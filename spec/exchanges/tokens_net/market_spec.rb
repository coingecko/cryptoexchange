require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::TokensNet::Market do
  it { expect(described_class::NAME).to eq 'tokens_net' }
  it { expect(described_class::API_URL).to eq 'https://api.tokens.net' }
end
