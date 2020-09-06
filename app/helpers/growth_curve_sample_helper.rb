module GrowthCurveSampleHelper
  # NOTE: GrowthCurveSampleController にも定数定義あり
  AGE_SLIDE = 3

  # 年齢 (n才〜m才) を AGE_SLIDE 分 前後させるためのリンクを生成する
  # 表示可能なデータ範囲を超えそうになった時、リンクではなくただの文字列を表示させる
  # NOTE: グラフの再描画時、キャッシュから旧い値が採用されてしまうため、リンク生成時に turbolinks を一時的に off にしている
  def age_slide_link(direction:)
    case direction
    when :prev
      # @current_max_ageは、growth_curve_sampleのindexメソッドから渡される
      if (0..AGE_SLIDE).cover?(@current_max_age)
        '<'
      else
        tag.a('<', href: growth_curve_sample_index_path(current_set_age: @current_max_age.to_i - AGE_SLIDE), data: { turbolinks: false })
      end
    when :next
      # @max_ageは、growth_curve_sample_controller.rbのindexメソッド内で定義
      if params[:current_set_age].to_i > @max_age.to_i
        '>'
      else
        tag.a('>', href: growth_curve_sample_index_path(current_set_age: @current_max_age.to_i + AGE_SLIDE), data: { turbolinks: false })
      end
    end
  end

  # 「< n才〜m才 >」の表示とその年齢操作リンクを生成する
  def age_slider
    [
      age_slide_link(direction: :prev),
      "#{@current_min_age}才 〜 #{@current_max_age}才",
      age_slide_link(direction: :next)
    ].each(&method(:concat))
  end

  # 年齢別にグループ分けをした growth_records を生成
  # { n才 => [a, b, c, ...], m才 => [w, x, y, ...]... }
  # <table/> データの生成に利用
  def grouped_by_age(growth_records)
    age_range =
      (growth_records.first.age..
       growth_records.last.age).to_a

    age_group = {}

    # キー値を初期化
    age_range.each { |age| age_group.update(age.to_s => []) }

    growth_records.each do |growth_record|
      age_group[growth_record.age.to_s] << growth_record
    end

    age_group
  end
end
