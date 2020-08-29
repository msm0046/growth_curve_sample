// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

window.draw_graph = function () {
  ctx = document.getElementById("myChart").getContext("2d");
  myChart = new Chart(ctx, {
    // 線グラフ
    type: "line",
    // データ
    data: {
      // X軸ラベル
      labels: gon.xLabels, // n才 mヶ月
      // データ設定
      datasets: [
        {
          // ラベル名
          label: "// 体重",
          // X軸データ
          data: gon.weight,
          // 背景色
          pointBackgroundColor: ["rgba(255, 99, 132, 0.2)"],
          // 折れ線の色
          //   ["rgba(54, 162, 235, 1)"],
          borderColor: gon.borderBlue,
          // 線の太さ
          borderWidth: 2,
          // 折れ線のみ表示
          fill: false,
          // Y軸ID指定
          yAxisID: "y-weight",
        },
        {
          // ラベル名
          label: "// 身長",
          // X軸データ
          data: gon.height,
          // 背景色
          pointBackgroundColor: ["rgba(255, 99, 132, 0.2)"],
          // 折れ線の色
          borderColor: gon.borderRed,
          // 線の太さ
          borderWidth: 2,
          // 折れ線のみ表示
          fill: false,
          // Y軸のID指定
          yAxisID: "y-height",
        },
      ],
    },
    options: {
      // レスポンシブ
      responsive: true,
      scales: {
        yAxes: [
          {
            // Y軸のID
            id: "y-height",
            // linear固定
            type: "linear",
            // どちら側に表示される軸か？
            position: "left",
            // 表示設定
            display: true,
            // 最大値・最小値設定
            ticks: {
              min: gon.minHeight,
              max: gon.maxHeight,
              stepSize: 5,
              callback: (value, _index, _values) => { return value + 'cm' }
            },
          },
          {
            id: "y-weight",
            // linear固定
            type: "linear",
            // どちら側に表示される軸か？
            position: "right",
            // 表示設定
            display: true,
            // 最大値最初値設定
            ticks: {
              min: gon.minWeight,
              max: gon.maxWeight,
              stepSize: 1,
              callback: (value, _index, _values) => { return value + 'kg' }
            },
            // 横グリッドを非表示に
            gridLines: {
              drawOnChartArea: false,
            },
          },
        ],
      },
    },
  });
};
