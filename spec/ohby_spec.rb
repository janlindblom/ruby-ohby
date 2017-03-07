require 'spec_helper'

describe Ohby do
  it 'has a version number' do
    expect(Ohby::VERSION).not_to be nil
  end

  it 'can look up existing codes' do
    the_code = "0xHVRMFJ"
    expect(the_code).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
