require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::JexFutures::Market do
  it { expect(described_class::NAME).to eq 'jex_futures' }
  it { expect(described_class::API_URL).to eq 'https://www.jex.com/api/v1' }
end
