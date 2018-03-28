require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::NLexch::Market do
  it { expect(described_class::NAME).to eq 'NLexch' }
  it { expect(described_class::API_URL).to eq 'https://www.nlexch.com/api/v2' }
end
