module GrowthCurveSampleHelper
  # NOTE: GrowthCurveSampleController にも定数定義あり
  AGE_SLIDE = 3.freeze

  # 年齢 (n才〜m才) を AGE_SLIDE 分 前後させるためのリンクを生成する
  # 表示可能なデータ範囲を超えそうになった時、リンクではなくただの文字列を表示させる
  # NOTE: グラフの再描画時、キャッシュから旧い値が採用されてしまうため、リンク生成時に turbolinks を一時的に off にしている
  def age_slide_link(direction:)
    prev_cond = (0..AGE_SLIDE).cover?(@current_max_age)
    next_cond = params[:current_set_age].to_i > @max_age

    a_link_or_text =
      lambda do |char, cond, calc_mark|
        if cond
          char
        else
          tag.a(char, href: growth_curve_sample_index_path(current_set_age: @current_max_age.to_i.public_send(calc_mark, AGE_SLIDE)), data: { turbolinks: false })
        end
      end

    case direction
    when :prev
      a_link_or_text.call('<', prev_cond, :-)
    when :next
      a_link_or_text.call('>', next_cond, :+)
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
