require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitholic::Market do
  let(:args) { {base: "btc", target: "qtum"} }

  it { expect(described_class::NAME).to eq 'bitholic' }
  it { expect(described_class::API_URL).to eq 'https://api.bitholic.com/public' }
  it { expect(described_class::trade_page_url(args)).to eq 'https://www.bitholic.com/exchange/btc-qtum' }

end
