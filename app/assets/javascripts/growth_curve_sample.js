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

// テーブルの <td/> から値を取得することを想定
// [編集], [削除] ボタンを押した行の値を取得
function getTableDataElementValue(context, name) {
  return (
    context.parentElement
           .parentElement
           .querySelector(''.concat('span.js-', name))
           .innerHTML
  );
}

// NOTE: set 系で再利用するので keys の順序は要固定
function getTableRowValues(context) {
  keys = ['id', 'height', 'weight', 'age_of_the_moon', 'age'];

  return (
    keys.map(key => { return getTableDataElementValue(context, key) })
  );
}

// [編集], [削除] ボタンで表示されるモーダルに値をセット
function setModalFormElementValue(prefix, name, value) {
  var target =
    document.querySelector(''.concat('#growth_record__', prefix, '-', name));

  target.value = value;
}

// [編集] ボタンを押したテーブル行の値をモーダルに転写
function transcribeTableDataToEditModalForm() {
  setModalFormElementValues('edit', getTableRowValues(this))
}

// [削除] ボタンを押したテーブル行の値をモーダルに転写
function transcribeTableDataToDeleteModalForm() {
  setModalFormElementValues('delete', getTableRowValues(this))
}

// テーブルの行から取得した値をモーダルに転写
function setModalFormElementValues(prefix, targetValues) {
  [id, height, weight, ageOfTheMoon, age] = targetValues;

  setModalFormElementValue(prefix, 'id', id);
  setModalFormElementValue(prefix, 'height', height);
  setModalFormElementValue(prefix, 'weight', weight);
  setModalFormElementValue(prefix, 'age_of_the_moon', ageOfTheMoon);
  setModalFormElementValue(prefix, 'age', age);
}

//
// onClick イベント設定
// [編集] ボタンにモーダルへの値の転写機能を付与
//
function setEditModalFromFormValuesOnClick(element) {
  element.addEventListener('click', transcribeTableDataToEditModalForm)
}

//
// onClick イベント設定
// [削除] ボタンにモーダルへの値の転写機能を付与
//
function setDeleteModalFromValuesOnClick(element) {
  element.addEventListener('click', transcribeTableDataToDeleteModalForm)
}

// ボタンクリックで data 属性値にある要素を対象に submit を実行
// data 属性値は <form/> の ID 指定を期待 (#some-form-name)
function formSubmit(context) {
  document.querySelector(context.dataset.submitFormTarget).submit();
}

// イベント処理の初期化
document.addEventListener('turbolinks:load', function() {
  // [編集] ボタンを押したときのモーダルへの値転写機能
  Array.from(document.querySelectorAll('.js-growth_record__edit'))
       .map((elm) => { setEditModalFromFormValuesOnClick(elm); });

  // [削除] ボタンを押したときのモーダルへの値転写機能
  Array.from(document.querySelectorAll('.js-growth_record__delete'))
       .map((elm) => { setDeleteModalFromValuesOnClick(elm); });
});
