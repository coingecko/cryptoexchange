require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::LetsDoCoinz::Market do
  it { expect(Cryptoexchange::Exchanges::LetsDoCoinz::Market::NAME).to eq 'lets_do_coinz' }
  it { expect(Cryptoexchange::Exchanges::LetsDoCoinz::Market::API_URL).to eq 'https://letsdocoinz.com/api/2' }
end
