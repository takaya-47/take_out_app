const calc = () => {
  const menuPrice = document.getElementById("menu-price");
  const quantity = document.getElementById("quantity");
  const totalPrice = document.getElementById("total-price");

  quantity.addEventListener('input', () => {
    const sum = menuPrice.innerHTML * quantity.value * 1.08
    const totalSum = Math.floor(sum);
    totalPrice.value = totalSum
  });
}

window.addEventListener('load', calc);