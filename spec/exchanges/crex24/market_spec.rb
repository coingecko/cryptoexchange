require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Crex24::Market do
  it { expect(described_class::NAME).to eq 'crex24' }
  it { expect(described_class::API_URL).to eq 'https://api.crex24.com/CryptoExchangeService/BotPublic' }
end
