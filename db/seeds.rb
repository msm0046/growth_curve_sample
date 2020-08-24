# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

GrowthRecord.destroy_all

# サンプルデータづくりのための可変データ
growth_record_params = {
  height: 20.1,
  weight: 2.0,
  age: 0,
  age_of_the_moon: 0
}

# 0才から6才までのデータを作成
6.times do
  # GrowthRecord を 12ヶ月分作成
  12.times do
    GrowthRecord.create!(
      growth_record_params
    )

    # サンプル成長記録なので単純に加算させる
    growth_record_params[:height] += 1.5
    growth_record_params[:weight] += 0.5
    growth_record_params[:age_of_the_moon] += 1
  end

  growth_record_params[:age_of_the_moon] = 0
  growth_record_params[:age] += 1
end
