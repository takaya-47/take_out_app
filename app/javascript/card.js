const payjp = () => {
  // テスト用パブリックキーを取得
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  // 対象となる入力フォームを取得
  const orderForm = document.getElementById("order-form");

  orderForm.addEventListener('submit', (e) => {
    e.preventDefault();

    // フォームのデータを取得するための変数を定義
    const formResult = document.getElementById("order-form");
    const formData = new FormData(formResult);

    // PAY.JPのサーバーと通信し、カード情報の認証を行い、トークンを作成
    const card = {
      number: formData.get("order_order_detail[number]"),
      cvc: formData.get("order_order_detail[cvc]"),
      exp_month: formData.get("order_order_detail[exp_month]"),
      exp_year: `20${formData.get("order_order_detail[exp_year]")}`
    };

  Payjp.createToken(card, function(status, response) {
    if (status === 200) {
      const token = response.id;
      // tokenが入力されたフォームを新たに生成してフォーム内に追加
      const form = document.getElementById("order-form");
      const tokenObj = document.createElement('input');
      tokenObj.setAttribute('name', "token");
      tokenObj.setAttribute('value', token);
      tokenObj.setAttribute('type', "hidden");
      form.appendChild(tokenObj);
    };
    // カード情報を削除
    document.getElementById("order_order_detail_number").removeAttribute("name");
    document.getElementById("order_order_detail_cvc").removeAttribute("name");
    document.getElementById("order_order_detail_exp_month").removeAttribute("name");
    document.getElementById("order_order_detail_exp_year").removeAttribute("name");
    // キャンセルしたフォーム送信処理を記述(サーバーサイドにフォームの内容を送る)
    document.getElementById("order-form").submit();
  });
});
}

window.addEventListener('load', payjp);