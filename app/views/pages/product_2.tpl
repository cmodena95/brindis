<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Roboto+Serif:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">

<div style="display: grid;
  grid-template-columns: 1fr 5fr;
  padding: 10vh 5vw;
  grid-gap: 2vw;">

  <div class="product-left">
    <div class="prod-info d-flex justify-content-between align-items-center">

      <ul style="margin-bottom: 0;">
        <li><h5 style="font-size: 1rem;">{{ product.name }}</h5></li>
      </ul>


        <div class="price-container mb-4" data-store="product-price-{{ product.id }}">
          <span class="d-inline-block">
              <span class="js-price-display {% if product_can_show_installments or (product.promotional_offer and not product.promotional_offer.script.is_percentage_off) %}mb-2{% endif %}" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %}>{% if product.display_price %}{{ product.price | money }}{% endif %}</span>
          </span>
          <span class="d-inline-block">
              <span id="compare_price_display" class="js-compare-price-display price-compare {% if product_can_show_installments or (product.promotional_offer and not product.promotional_offer.script.is_percentage_off) %}mb-2{% endif %}" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %} style="display:block;"{% endif %}>{% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}</span>
          </span>
        </div>
    </div>
    <img src="https://d3ugyf2ht6aenh.cloudfront.net/stores/001/206/817/products/campera-saya1-516f16b12d47476b1a16815065696588-640-0.webp" style=" object-fit: cover;
    width: 35vw;
    height: 80vh;">
  </div>

  <div class="product-right" style="display: flex; flex-direction: column; justify-content: center;">
    <div style="border-bottom: 1.5px solid black; padding-bottom: 3vh;">
      <div class="d-flex" style="width: 50%;">
        {% if product.variations %}
            {% include "snipplets/product/product-variants.tpl" %}
        {% endif %}

        {% if product.available and product.display_price %}
            {% include "snipplets/product/product-quantity.tpl" %}
        {% endif %}
      </div>
    </div>


    <div class="d-flex align-items-center" style="border-bottom: 1.5px solid black; padding: 1vh 0;">
      <img src="https://i.ibb.co/QYdm8MM/Icono-Planta.png" style="height: 12vh; width: 5vw;">

      <div style="width: 100%; margin-left: 10px;">

          {% include "snipplets/payments/installments.tpl" with {'product_detail' : true} %}

          
      </div>
       




      </div>
    </div>

    // <%# info %>
    <div style="padding: 3vh 0; border-bottom: 1.5px solid black;">
      <p>Info</p>
    </div>

    // <%# envio %>
    <div style="display: grid; grid-template-columns: 3fr 2fr; padding: 3vh 0; border-bottom: 1.5px solid black;">
      <div>
        <p>"Envío brindis"</p>
        <p>Caba: $600</p>
        <p>Vicente Lopez, Martinez, San Isidro: $1000</p>
        <p>Victoria, San Fernando, Tigre, Don Torcuato, Garin, Benavidez: $1000</p>
        <p>Pilar, Escobar, Quilmes, Lomas de Zamora, Banfield, Temperley: $1500</p>
      </div>

      <div class="d-flex">
        <img src='https://i.ibb.co/LS1VsjB/envios.png" style="height: 5vh; margin-right: 1vw'>

        <div>
          <p><strong>Envio Gratis</strong></p>
          <p>Domicilio Céspedes 3146 piso 1 , Colegiales - Atención de Lun. a Vie. de 13 a 18 con previo aviso</p>
        </div>
      </div>
    </div>

    // <%# añadir %>
    // <%# btn here %>
  </div>
</div>