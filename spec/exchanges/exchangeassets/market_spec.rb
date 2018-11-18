require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Exchangeassets::Market do
  it { expect(described_class::NAME).to eq 'exchangeassets' }
  it { expect(described_class::API_URL).to eq 'https://exchange-assets.com/api/public' }
end
