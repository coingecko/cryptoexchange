require "spec_helper"

RSpec.describe Cryptoexchange::Exchanges::StellarTerm::Market do
  it { expect(described_class::NAME).to eq "stellar_term" }
  it { expect(described_class::API_URL).to eq "https://api.stellarterm.com/v1" }
end
