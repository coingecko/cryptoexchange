require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::MercadoNiobioCash::Services::Pairs do
  it { expect(described_class::PAIRS_URL).to eq 'https://www.mercadoniobiocash.com.br/public_api/' }
end
