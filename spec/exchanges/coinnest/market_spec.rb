require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinnest::Market do
  it { expect(described_class::NAME).to eq 'coinnest' }
  it { expect(described_class::API_URL).to eq 'https://api.coinnest.co.kr' }
end
