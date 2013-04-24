require 'spec_helper'

describe Order do
  it { should have_one(:payment) }
end
