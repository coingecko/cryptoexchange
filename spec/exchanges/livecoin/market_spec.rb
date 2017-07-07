require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Livecoin::Market do
  it { expect(Cryptoexchange::Exchanges::Livecoin::Market::NAME).to eq 'livecoin' }
  it { expect(Cryptoexchange::Exchanges::Livecoin::Market::API_URL).to eq 'https://api.livecoin.net' }
end
