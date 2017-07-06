require "spec_helper"

RSpec.describe Cryptoexchange do
  it "has a version number" do
    expect(Cryptoexchange::VERSION).not_to be nil
  end
end
