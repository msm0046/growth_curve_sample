class GrowthCurveSampleController < ApplicationController
  def index
    growth_records = GrowthRecord.all

    gon_set_values = {
      # 身長・体重のマッピング
      height: growth_records.map { |attr| attr.height },
      weight: growth_records.map { |attr| attr.weight },
      # 描画色の設定
      borderRed: BORDER_COLOR_RED,
      borderBlue: BORDER_COLOR_BLUE
    }

    gon_set_values.each do |key, value|
      set_gon_variable_as(key: key, value: value)
    end
  end

  private

  def set_gon_variable_as(key:, value:)
    gon.public_send("#{key}=", value)
  end
end
