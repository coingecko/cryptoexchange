require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Yobit::Market do
  it { expect(described_class::NAME).to eq 'yobit' }
  it { expect(described_class::API_URL).to eq 'https://yobit.net/api/3' }
end
