require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Credoex::Market do
  it { expect(described_class::NAME).to eq 'credoex' }
  it { expect(described_class::API_URL).to eq 'https://credoex.com' }
end
