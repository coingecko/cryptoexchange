require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ethfinex::Market do
  it { expect(described_class::NAME).to eq 'ethfinex' }
  it { expect(described_class::API_URL).to eq 'https://api-pub.ethfinex.com' }
end
