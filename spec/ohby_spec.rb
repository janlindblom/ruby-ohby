require 'spec_helper'

describe Ohby do
  it 'has a version number' do
    expect(Ohby::VERSION).not_to be nil
  end

  it 'can look up existing codes' do
    the_code = "HVRMFJ"
    expect(the_code).not_to be nil

    lookup = Ohby.lookup(the_code)
    expect(lookup).not_to be nil
    expect(lookup.code).to eq the_code

    the_code = "0x" + the_code

    lookup = Ohby.lookup(the_code)
    expect(lookup).not_to be nil
    expect(lookup.code).to eq the_code.slice(2..-1)
  end

end
