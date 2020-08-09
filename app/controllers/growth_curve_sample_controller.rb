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

    # NOTE: chart-js で値の数だけ色指定が必要
    border_blue = 'rgba(54, 162, 235, 1)'
    # gon.borderBlue = Array.new(weight.size) { border_blue }
    gon.borderBlue =
      generate_border_color_propertiy(generate_size: weight.size, rgba: border_blue)
  end

  private

  def generate_border_color_propertiy(generate_size:, rgba:)
    Array.new(generate_size) { rgba }
  end
end
