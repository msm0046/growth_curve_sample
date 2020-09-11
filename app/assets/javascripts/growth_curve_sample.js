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

// growth_curve_sample/edit での使用を想定
// 1. <table/> に表示される [編集], [削除] ボタンをクリック
// 2. 当該行の「年齢」「月齢」「体重」「身長」をモーダルに転写
class TableModalTranscriber {
  // context = 別の場所の this
  constructor(context, targetPrefix) {
    this.context = context;
    this.targetPrefix = targetPrefix;
  }

  transcribe() {
    this._setModalFormElementValues();
  }

  // [編集], [削除] ボタンのある行から指定した名前の値を取得
  _getTableRowValue(name) {
    return (
      this.context.parentElement
                  .parentElement
                  .querySelector(''.concat('span.js-', name))
                  .innerHTML
    );
  }

  _getTableRowValues() {
    // NOTE: set 系で再利用するので keys の順序は要固定
    let keys = ['id', 'height', 'weight', 'age_of_the_moon', 'age'];

    return (
      keys.map(key => { return this._getTableRowValue(key) })
    );
  }

  // 指定した名前の要素に値をセット
  _setModalFormElementValue(name, value) {
    var target =
      document.querySelector(
        ''.concat('#growth_record__', this.targetPrefix, '-', name)
      );

    target.value = value;
  }

  // [編集], [削除] ボタンで表示されるモーダルに値をセット
  _setModalFormElementValues() {
    let rowValues = function (context) {
      let keys = ['id', 'height', 'weight', 'age_of_the_moon', 'age'];
      let values = context._getTableRowValues();

      // {key: value} の生成
      return Object.fromEntries(keys.map((_v, i) => [keys[i], values[i]]));
    }(this);

    let self = this;

    Object.keys(rowValues).forEach(key => {
      self._setModalFormElementValue(key, rowValues[key]);
    })
  }
}

// growth_curve_sample/edit での使用を想定
// 当該 <button/> 要素に、Click イベントに対して TableModalTranscriber クラスの機能を付与
class TranscribeEventRegistrar{
  register() {
    // [編集], [削除] ボタンを押したときのモーダルへの値転写機能を付与
    [
      ['.js-growth_record__edit', this._transcribeTableDataToEditModalForm],
      ['.js-growth_record__delete', this._transcribeTableDataToDeleteModalForm]
    ].forEach(([selector, method]) => {
      this._registerEvent(selector, method);
    })
  }

  // イベント登録用メソッド
  // [編集] ボタンを押したテーブル行の値をモーダルに転写
  _transcribeTableDataToEditModalForm() {
    var transcriber = new TableModalTranscriber(this, 'edit')

    transcriber.transcribe();
  }

  // イベント登録用メソッド
  // [削除] ボタンを押したテーブル行の値をモーダルに転写
  _transcribeTableDataToDeleteModalForm() {
    var transcriber = new TableModalTranscriber(this, 'delete')

    transcriber.transcribe();
  }

  _registerEvent(selector, method) {
    document.querySelectorAll(selector)
      .forEach((elm) => {
        elm.addEventListener('click', method)
      });
  }
}

// ボタンクリックで data 属性値にある要素を対象に submit を実行
// data 属性値は <form/> の ID 指定を期待 (#some-form-name)
function formSubmit(context) {
  document.querySelector(context.dataset.submitFormTarget).submit();
}

// イベント処理の初期化
document.addEventListener('turbolinks:load', function() {
  // [編集], [削除] ボタンを押したときのモーダルへの値転写機能を付与
  let eventRegistrar = new TranscribeEventRegistrar();
  eventRegistrar.register();
});
