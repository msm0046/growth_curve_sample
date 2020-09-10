class GrowthCurveSampleController < ApplicationController
  BORDER_COLOR_RED  = 'rgba(255,   0,   0, 1)'.freeze
  BORDER_COLOR_BLUE = 'rgba( 54, 162, 235, 1)'.freeze
  AGE_SLIDE = 3 # NOTE: GrowthCurveSampleHelper にも定数定義あり

  def index
    params[:current_set_age] ||= AGE_SLIDE # データ未定義の場合 定数値を代入
    # スプラットオペレータ
    @current_min_age, *_middle_values, @current_max_age = age_range(params[:current_set_age]).to_a

    # order(:age_of_the_moon)指定がない場合は、昇順の値を取得する
    # reorder(:age)もう一度、並べ替え
    @growth_records =
      GrowthRecord.where(age: age_range(params[:current_set_age]))
                  .order(:age_of_the_moon)
                  .reorder(:age)

    # TODO: 特定の子供だけの情報に絞り込んで、情報を取得する

    # growth_curve_sample.helperで使用
    # ageカラムの最大値を取得する
    @max_age = GrowthRecord.maximum(:age)

    gon_set_values = {
      # 身長・体重のマッピング
      height: @growth_records.map(&:height),
      weight: @growth_records.map(&:weight),
      # 身長・体重のスケールを設定
      minHeight: GrowthRecord.minimum(:height),
      maxHeight: GrowthRecord.maximum(:height),
      maxWeight: GrowthRecord.maximum(:weight),
      minWeight: GrowthRecord.minimum(:weight),
      # 「n才mヶ月」のラベル設定
      xLabels: x_labels(@growth_records),
      # 描画色の設定
      borderRed: BORDER_COLOR_RED,
      borderBlue: BORDER_COLOR_BLUE
    }

    gon_set_values.each do |key, value|
      set_gon_variable_as(key: key, value: value)
    end

    # index にフォームを書くので ここで new する
    @growth_record = GrowthRecord.new
  end

  def create
    @growth_record = GrowthRecord.new(growth_record_params)

    # flash メッセージの設定
    if @growth_record.save
      flash[:success] = 'レコードを作成しました!'
    else
      flash[:error] = 'レコードを作成できませんでした'
      flash[:error_messages] = @growth_record.errors.messages
    end

    redirect_to growth_curve_sample_index_path
  end

  def edit
    @growth_records =
      GrowthRecord.all
                  .reorder(:age)
                  .order(:age_of_the_moon)
  end

  def update
    @growth_record = GrowthRecord.find(params[:id])

    if @growth_record.update(growth_record_params)
      redirect_to growth_curve_sample_edit_path
    else
      render growth_curve_sample_edit_path
    end
  end

  def destroy
    @growth_record = GrowthRecord.find(params[:id])
    @growth_record.destroy

    redirect_to growth_curve_sample_edit_path
  end

  private

  def set_gon_variable_as(key:, value:)
    gon.public_send("#{key}=", value)
  end

  # chart.js x軸ラベルを生成
  def x_labels(growth_records)
    growth_records.map { |record| "#{record.age}才#{record.age_of_the_moon}ヶ月" }
  end

  # 3年間を一区切りに、データを表示させる範囲を生成
  def age_range(current_max_age)
    case current_max_age.to_i
    when 0..(AGE_SLIDE - 1)
      0..AGE_SLIDE
    else
      (current_max_age.to_i - AGE_SLIDE)..current_max_age.to_i
    end
  end

  def growth_record_params
    params.require(:growth_record)
          .permit(:age, :height, :weight, :age_of_the_moon) # ... 必要なパラメータを設定
  end
end
