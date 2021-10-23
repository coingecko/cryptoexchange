require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitforexFutures::Market do
  it { expect(described_class::NAME).to eq 'bitforex_futures' }
  it { expect(described_class::API_URL).to eq 'https://www.bitforex.com/contract/mkapi/v2/' }
end
