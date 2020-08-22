class GrowthCurveSampleController < ApplicationController
  BORDER_COLOR_RED  = 'rgba(255,   0,   0, 1)'.freeze
  BORDER_COLOR_BLUE = 'rgba( 54, 162, 235, 1)'.freeze

  def index
    @growth_records = GrowthRecord.all
    # TODO: 特定の子供だけの情報に絞り込んで、情報を取得する

    gon_set_values = {
      # 身長・体重のマッピング
      height: @growth_records.map(&:height),
      weight: @growth_records.map(&:weight),
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

  # TODO: CRUD の残りの部分を作成

  def create
    @growth_record = GrowthRecord.new(growth_record_params)
    @growth_record.save # 保存する
  end

  private

  def set_gon_variable_as(key:, value:)
    gon.public_send("#{key}=", value)
  end

  def growth_record_params
    params.require(:growth_record)
          .permit(:age, :height, :weight, :age_of_the_moon) # ... 必要なパラメータを設定
  end
end
