require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Gemini::Market do
  it { expect(described_class::NAME).to eq 'gemini' }
  it { expect(described_class::API_URL).to eq 'https://api.gemini.com/v1' }
end
