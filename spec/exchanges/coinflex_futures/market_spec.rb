require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::CoinflexFutures::Market do
  it { expect(described_class::NAME).to eq 'coinflex_futures' }
  it { expect(described_class::API_URL).to eq 'https://webapi.coinflex.com' }
end
