class GrowthCurveSampleController < ApplicationController
  def index
    # 仮で固定値
    height = [46, 51, 55, 59, 62, 63, 64, 65.5, 66, 66.5, 71, 69.5]
    # 12.times.map { (30..70).to_a.sample }
    # gon.height = height
    gon.height = 12.times.map { (40..70).to_a.sample }

    # NOTE: chart-js で値の数だけ色指定が必要
    border_red = 'rgba(255, 0, 0, 1)'
    gon.borderRed = Array.new(height.size) { border_red }

    # -----------------------------------------

    # 仮で固定値
    weight = [2.26, 3.445, 4.62, 5, 6.05, 6.64, 7.1, 7.4, 7.5, 7.6, 7.8, 7.5]
    gon.weight = weight

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
