require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::ZbgFutures::Market do
  it { expect(described_class::NAME).to eq 'zbg_futures' }
  it { expect(described_class::API_URL).to eq 'https://www.zbg.com/exchange/api/v1/common/future' }
end
