function price (){
console.log("OK")
  const priceForm = document.getElementById("item-price");
  priceForm.addEventListener("keyup", () => {
    const countPrice = priceForm.value;
    const addTaxPrice= document.getElementById("add-tax-price");
    addTaxPrice.innerHTML=`${countPrice * 0.1}`
    const profit= document.getElementById("profit");
    profit.innerHTML=`${countPrice * 0.9}`
  });
}

window.addEventListener('load', price);