describe GrowthCurveSampleController do
  describe '定数の定義' do
    subject { GrowthCurveSampleController }

    it { is_expected.to be_const_defined :BORDER_COLOR_RED }
    it { is_expected.to be_const_defined :BORDER_COLOR_BLUE }
  end

  describe 'GET #index' do
    include_context :gon

    it 'gon の値がセットされている' do
      get :index

      # NOTE: 色設定は定数・固定値なのでテスト値として採用
      # 心配なら変動値もデータを用意してテストする
      expect(gon['borderRed']).to eq 'rgba(255,   0,   0, 1)'
      expect(gon['borderBlue']).to eq 'rgba( 54, 162, 235, 1)'
    end
  end
end
