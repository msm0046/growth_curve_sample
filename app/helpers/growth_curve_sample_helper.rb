module GrowthCurveSampleHelper
  # NOTE: GrowthCurveSampleController にも定数定義あり
  AGE_SLIDE = 3.freeze

  # 年齢 (n才〜m才) を AGE_SLIDE 分 前後させるためのリンクを生成する
  # 表示可能なデータ範囲を超えそうになった時、リンクではなくただの文字列を表示させる
  def age_slide_link(direction:)
    case direction
    when :prev
      if (0..AGE_SLIDE).cover?(@current_max_age)
        '<'
      else
        tag.a('<', href: growth_curve_sample_index_path(current_set_age: @current_max_age.to_i - AGE_SLIDE))
      end
    when :next
      if params[:current_set_age].to_i > @max_age
        '>'
      else
        tag.a('>', href: growth_curve_sample_index_path(current_set_age: @current_max_age.to_i + AGE_SLIDE))
      end
    end
  end

  # 「< n才〜m才 >」の表示とその年齢操作リンクを生成する
  def age_slider
    concat(age_slide_link(direction: :prev))
    concat( "#{@current_min_age}才 〜 #{@current_max_age}才")
    concat(age_slide_link(direction: :next))
  end
end
