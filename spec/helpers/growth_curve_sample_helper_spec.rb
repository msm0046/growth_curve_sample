describe GrowthCurveSampleHelper do
  describe '#age_slide_link' do
    context 'direction: :prev' do
      before { @max_age = 0 } # prev では使わないが動作に必要

      context '文字列が返るパターン' do
        it '@current_max_age が 3 のとき' do
          @current_max_age = 3
          expect(age_slide_link(direction: :prev)).to eq '<'
        end

        it '@current_max_age が 0 のとき' do
          @current_max_age = 0
          expect(age_slide_link(direction: :prev)).to eq '<'
        end
      end

      context 'リンクが返るパターン' do
        it '@current_max_age が 4 のとき' do
          @current_max_age = 4

          expect(age_slide_link(direction: :prev)).to match /^<a/
        end
      end
    end

    context 'direction: :next' do
      context '文字列が返るパターン' do
        it 'params[:current_set_age] が @max_age よりも大きいとき' do
          params[:current_set_age] = 9
          @max_age = 3

          expect(age_slide_link(direction: :next)).to eq '>'
        end
      end

      context 'リンクが返るパターン' do
        it 'params[:current_set_age] が @max_age よりも大くないとき' do
          params[:current_set_age] = 3
          @max_age = 9

          expect(age_slide_link(direction: :next)).to match /^<a/
        end
      end
    end
  end
end
