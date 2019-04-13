require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cbx::Market do
  it { expect(Cryptoexchange::Exchanges::Cbx::Market::NAME).to eq 'cbx' }
  it { expect(Cryptoexchange::Exchanges::Cbx::Market::API_URL).to eq 'https://www.cbx.one/api/v2' }
end
