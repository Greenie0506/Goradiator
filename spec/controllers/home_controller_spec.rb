require 'spec_helper'

describe HomeController do
  context 'on page load' do
    it 'should get the sponsors from the APP_CONFIG' do
      APP_CONFIG.stub(:[]).with('sponsors').and_return("Sponsors")
      get 'index'
      assigns(:sponsors).should == "Sponsors"
    end
  end
end
