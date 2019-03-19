require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::HuobiUs::Market do
  it { expect(described_class::NAME).to eq 'huobi_us' }
  it { expect(described_class::DOT_PRO_API_URL).to eq 'https://api.huobi.com' }
end
