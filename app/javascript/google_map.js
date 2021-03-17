// Create the script tag, set the appropriate attributes
const script = document.createElement('script');
script.src = `https://maps.googleapis.com/maps/api/js?key=${process.env.GOOGLE_MAPS_API_KEY}&callback=initMap`;
script.async = true;

// Append the 'script' element to 'head'
document.head.appendChild(script);

// Attach your callback function to the `window` object
window.initMap = function () {
  // マップの表示領域を取得
  const target = document.getElementById('map');
  // ジオコーディングのインスタンスの生成
  const geocoder = new google.maps.Geocoder();
  // 店舗詳細ページのテキストから住所を取得
  const address = document.getElementById('address').innerText;

  // 引数に取得した住所と関数を渡し、Google MapsAPIジオコーディングサービスにアクセス
  // 関数内のif文は返ってきたレスポンスに対する処理
  geocoder.geocode({ address: address }, function (results, status) {
    if (results[0] && status === "OK") {
      // 地図の作成
      const map = new google.maps.Map(target, {
        center: results[0].geometry.location,
        zoom: 16,
      })

      // 地図内にマーカーの設置
      const marker = new google.maps.Marker({
        position: results[0].geometry.location,
        map: map,
      });
    } else {
      alert("失敗しました： " + status);
    }
  });
};
