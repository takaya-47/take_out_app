const calc = () => {
  const menuPrice = document.getElementById("menu-price");
  const quantity = document.getElementById("order_order_detail_quantity");
  const totalPrice = document.getElementById("order_order_detail_total_price");

  quantity.addEventListener('input', () => {
    const sum = menuPrice.innerHTML * quantity.value * 1.08
    const totalSum = Math.floor(sum);
    totalPrice.value = totalSum
  });
}

window.addEventListener('load', calc);