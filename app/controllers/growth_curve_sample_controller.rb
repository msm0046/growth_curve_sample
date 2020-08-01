class GrowthCurveSampleController < ApplicationController
  BORDER_COLOR_RED = 'rgba(255, 0, 0, 1)'.freeze
  BORDER_COLOR_BLUE = 'rgba(54, 162, 235, 1)'.freeze

  def index
    gon_set_values = {
      # 仮で固定値
      height: [46, 51, 55, 59, 62, 63, 64, 65.5, 66, 66.5, 71, 69.5],
      weight: [2.26, 3.445, 4.62, 5, 6.05, 6.64, 7.1, 7.4, 7.5, 7.6, 7.8, 7.5],
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
