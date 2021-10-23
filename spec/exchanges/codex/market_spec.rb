require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Codex::Market do
  it { expect(described_class::NAME).to eq 'codex' }
  it { expect(described_class::API_URL).to eq 'https://api.codex.one' }
end
