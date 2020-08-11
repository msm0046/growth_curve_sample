# Ref: [How To: Test controllers with Rails (and RSpec) · heartcombo/devise Wiki](https://github.com/heartcombo/devise/wiki/How-To:-Test-controllers-with-Rails-(and-RSpec))
shared_context :gon do
  let(:gon) { RequestStore.store[:gon].gon }
  before { Gon.clear }
end
