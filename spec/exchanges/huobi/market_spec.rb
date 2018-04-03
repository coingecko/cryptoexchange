require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Huobi::Market do
  it { expect(described_class::NAME).to eq 'huobi' }
  it { expect(described_class::DOT_PRO_API_URL).to eq 'https://api.huobi.pro' }
end
