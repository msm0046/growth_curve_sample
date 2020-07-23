# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.draw_graph = -> 
    ctx = document.getElementById("myChart").getContext('2d')
    myChart = new Chart(ctx, {
        # 線グラフ
        type: 'line',
        # データ
        data: {
            # X軸ラベル
            labels: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
            # データ設定
            datasets: [{
                # ラベル名
                label: '# 体重',
                # X軸データ
                data: [2.26, 3.445, 4.62, 5, 6.05, 6.64, 7.1, 7.4, 7.5, 7.6, 7.8, 7.5],
                # 背景色
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                # 折れ線の色
                borderColor: [
                    'rgba(255,99,132,1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                # 線の太さ
                borderWidth: 1
            }]
        },
        options: {
            # レスポンシブ
            responsive: true,
            scales: {
                # Y軸設定
                yAxes: [{
                    # 表示設定
                    display: true,
                    # 最大値最初値設定
                    ticks: {
                        min: 0,
                        max: 10,
                        stepSize: 1
                    }
                }]
            }
        }
    })