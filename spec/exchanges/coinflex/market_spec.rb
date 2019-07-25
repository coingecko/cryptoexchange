require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinflex::Market do
  it { expect(described_class::NAME).to eq 'coinflex' }
  it { expect(described_class::API_URL).to eq 'https://webapi.coinflex.com' }
end
