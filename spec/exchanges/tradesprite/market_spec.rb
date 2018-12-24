require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Tradesprite::Market do
  it { expect(described_class::NAME).to eq 'tradesprite' }
  it { expect(described_class::API_URL).to eq 'https://alpha.tradesprite.com/hydrasocket/v2' }
end
