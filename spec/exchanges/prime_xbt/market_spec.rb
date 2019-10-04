require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::PrimeXbt::Market do
  it { expect(described_class::NAME).to eq 'prime_xbt' }
  it { expect(described_class::API_URL).to eq 'https://api.primexbt.com/v1' }
end
