<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

{# Payments details #}
<div id="single-product" class="js-has-new-shipping js-product-detail js-product-container js-shipping-calculator-container" data-variants="{{product.variants_object | json_encode }}">
    <div class="container-fluid p-0">
        <div class="section-single-product no-gutters mb-md-4">

            <div>
              <div class="d-flex justify-content-between align-items-center info-top">
                {# Product name and breadcrumbs #}

                <h5 style="margin-bottom: 0;" class="serif">{{ product.name }}</h5>

                {# Product price #}

                <div class="price-container" data-store="product-price-{{ product.id }}">
                    <span class="d-inline-block">
                        <span class="js-price-display serif {% if product_can_show_installments or (product.promotional_offer and not product.promotional_offer.script.is_percentage_off) %}mb-2{% endif %}" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %}>{% if product.display_price %}{{ product.price | money }}{% endif %}</span>
                    </span>
                    <span class="d-inline-block">
                      <span id="compare_price_display" class="serif js-compare-price-display price-compare {% if product_can_show_installments or (product.promotional_offer and not product.promotional_offer.script.is_percentage_off) %}mb-2{% endif %}" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %} style="display:block;"{% endif %}>{% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}</span>
                    </span>
                </div>
              </div>

              <div data-store="product-image-{{ product.id }}" style="height: 80vh; position: sticky; top: 9vh;">

                {% set has_multiple_slides = product.images_count > 1 or product.video_url %}

                {% if product.images_count > 0 %}
                  <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel" data-bs-interval="false" style="height: 100%;">
                    <div class="carousel-inner" style="height: 100%;">
                      {% for image in product.images %}
                        <div class="carousel-item">
                          <div class="js-product-slide swiper-slide slider-slide product-slide" data-image="{{image.id}}" data-image-position="{{loop.index0}}">
                            <a href="{{ image | product_image_url('huge') }}" data-fancybox="product-gallery" class="d-block p-relative" style="padding-bottom: {{ image.dimensions['height'] / image.dimensions['width'] * 100}}%;">
                              <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{  image | product_image_url('large') }} 480w, {{  image | product_image_url('huge') }} 640w' data-sizes="auto" class="js-product-slide-img product-slider-image img-absolute img-absolute-centered lazyautosizes lazyload" {% if image.alt %}alt="{{image.alt}}"{% endif %}/>
                              <img src="{{ image | product_image_url('tiny') }}" class="js-product-slide-img product-slider-image img-absolute img-absolute-centered blur-up" {% if image.alt %}alt="{{image.alt}}"{% endif %} />
                            </a>
                        </div>
                      </div>
                    {% endfor %}
                  </div>
                  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" style="height: 100%;" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                  </button>
                  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" style="height: 100%;" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                  </button>
                </div>
              {% endif %}



              </div>

            </div>


            <div data-store="product-info-{{ product.id }}">
              <div class="js-sticky-product">
                  <div class="product-detail-container{% if settings.positive_color_background %} container-invert{% endif %}">


                    <div class="{% if product.variations %}js-product-variants{% else %}js-product-without-variants{% endif %} form-row">
                      {% if product.variations %}

                        {% if quickshop and product.variations | length == 1 %}
                          {% set form_group_class = 'mb-0 mb-md-4' %}
                        {% else %}
                          {% set form_group_class = '' %}
                        {% endif %}

                        {% for variation in product.variations %}
                            <div class="js-product-variants-group {% if variation.name in ['Color', 'Cor'] %}js-color-variants-container{% endif %} {% if quickshop %}{% if loop.length == 3 %}  col-md-2{% endif %} {% if loop.length == 2 or loop.length == 3 %} col-6 {% else %} col col-md{% endif %}{% else %}col-6{% endif %}">
                                {% embed "snipplets/forms/form-select.tpl" with{select_label: true, select_label_name: '' ~ variation.name ~ '', select_for: 'variation_' ~ loop.index , select_data: 'variant-id', select_data_value: 'variation_' ~ loop.index, select_name: 'variation' ~ '[' ~ variation.id ~ ']',select_group_custom_class: form_group_class, select_custom_class: 'js-variation-option js-refresh-installment-data'} %}
                                    {% block select_options %}
                                        {% for option in variation.options %}
                                            <option value="{{ option.id }}" {% if product.default_options[variation.id] == option.id %}selected="selected"{% endif %}>{{ option.name }}</option>
                                        {% endfor %}
                                    {% endblock select_options%}
                                {% endembed %}

                            </div>
                        {% endfor %}

                      {% endif %}

                      {% if product.available and product.display_price %}
                        {# Product quantity #}

                        {# Define variants and quantity col distribution depending on quickshop or product detail #}

                        {% if quickshop %}

                            {% set quantity_visibility = 'd-md-none' %}

                            {% if product.variations %}
                                {% if product.variations | length == 3 %}
                                    {% set mobile_col, desktop_col, quantity_group_class = '6', '2', 'mb-4 mb-md-0' %}
                                {% else %}
                                    {% set mobile_col, quantity_group_class = '12', 'mb-0' %}
                                {% endif %}
                                {% if product.variations | length == 2 %}
                                    {% set desktop_col = '8' %}
                                {% elseif product.variations | length == 1 %}
                                    {% set desktop_col = '4' %}
                                {% endif %}
                            {% else %}
                                {% set mobile_col, desktop_col = '' , '' %}
                            {% endif %}
                        {% else %}
                            {% set quantity_group_class, quantity_visibility = '', '' %}
                            {% if product.variations %}
                                {% if product.variations | length == 1 or product.variations | length == 3 %}
                                    {% set mobile_col, desktop_col = '6', '6' %}
                                {% else %}
                                    {% set mobile_col, desktop_col = '12', '6' %}
                                {% endif %}
                            {% else %}
                                {% set mobile_col, desktop_col = '12', '4' %}
                            {% endif %}
                        {% endif %}

                        <div class="{% if quickshop %}mt-md-1{% endif %} col-{{ mobile_col }} col-md-{{ desktop_col }}">
                            {% embed "snipplets/forms/form-input.tpl" with{type_number: true, input_value: '1', input_name: 'quantity' ~ item.id, input_custom_class: 'js-quantity-input form-control-quantity text-center', input_label_text: 'Cantidad' | translate, input_label_custom_class: quantity_visibility, input_append_content: true, input_group_custom_class: 'js-quantity ' ~ quantity_group_class ~ '', form_control_container_custom_class: '', input_min: '1', input_aria_label: 'Cambiar cantidad' | translate } %}
                            {% endembed %}
                        </div>

                      {% endif %}

                      {% if settings.last_product %}
                          <div class="{% if product.variations %}js-last-product {% endif %}col-12 text-center text-md-left"{% if product.selected_or_first_available_variant.stock != 1 %} style="display: none;"{% endif %}>
                              <div class="h6 h-font-body text-accent font-weight-bold mb-4">
                                  {{ settings.last_product_text }}
                              </div>
                          </div>
                      {% endif %}
                      </div>


                      {# Promotional text #}

                      {% if product.promotional_offer and not product.promotional_offer.script.is_percentage_off and product.display_price %}
                          <div class="js-product-promo-container" data-store="product-promotion-info">
                              {% if product.promotional_offer.script.is_discount_for_quantity %}
                                  {% for threshold in product.promotional_offer.parameters %}
                                      <h4 class="mb-2 text-accent h-font-body"><strong>{{ "¡{1}% OFF comprando {2} o más!" | translate(threshold.discount_decimal_percentage * 100, threshold.quantity) }}</strong></h4>
                                  {% endfor %}
                              {% else %}
                                  <h4 class="mb-2 text-accent h-font-body"><strong>{{ "¡Llevá {1} y pagá {2}!" | translate(product.promotional_offer.script.quantity_to_take, product.promotional_offer.script.quantity_to_pay) }}</strong></h4> 
                              {% endif %}
                              {% if product.promotional_offer.scope_type == 'categories' %}
                                  <p>{{ "Válido para" | translate }} {{ "este producto y todos los de la categoría" | translate }}:  
                                  {% for scope_value in product.promotional_offer.scope_value_info %}
                                    {{ scope_value.name }}{% if not loop.last %}, {% else %}.{% endif %}
                                  {% endfor %}</br>{{ "Podés combinar esta promoción con otros productos de la misma categoría." | translate }}</p>
                              {% elseif product.promotional_offer.scope_type == 'all'  %}
                                  <p>{{ "Vas a poder aprovechar esta promoción en cualquier producto de la tienda." | translate }}</p>
                              {% endif %}  
                          </div> 
                      {% endif %}

                      {# Product installments #}


                      {% if product %}

                        {% set hasDiscount = product.maxPaymentDiscount.value > 0 %}

                        {% set product_detail = true %}

                        {# Product installments #}

                        {% if product.show_installments and product.display_price %}

                          {% set installments_info_base_variant = product.installments_info %}
                          {% set installments_info = product.installments_info_from_any_variant %}

                          {# If product detail installments, include container with "see installments" link #}


                          <div class="d-flex" style="border-top: 1.5px solid black; border-bottom: 1.5px solid black; padding: 2vh 0;">
                            <img src="https://i.ibb.co/QYdm8MM/Icono-Planta.png" style="height: 12vh; width: 5vw; object-fit: contain;" class="plant">

                            <div style="flex-grow: 1;">
                              {% if product_detail and ( installments_info or hasDiscount ) %}
                                <div data-bs-toggle="modal" data-bs-target="#exampleModal" style="display: flex;
                                box-shadow: 2px 2px 5px rgba(0,0,0,0.25);
                                justify-content: space-between;
                                align-items: center;
                                border-radius: 15px;
                                padding: 10px;" data-modal-url="modal-fullscreen-payments" class="js-modal-open js-fullscreen-modal-open payment-info js-product-payments-container mb-2" {% if (not product.get_max_installments) and (not product.get_max_installments(false)) %}style="display: none;"{% endif %}>
                              {% endif %}

                              {% set product_can_show_installments = product.show_installments and product.display_price and product.get_max_installments.installment > 1 %}

                              {% if product_can_show_installments %}

                                {% set max_installments_without_interests = product.get_max_installments(false) %}
                                {% set max_installments_with_interests = product.get_max_installments %}

                                {% set has_no_interest_payments = max_installments_without_interests and max_installments_without_interests.installment > 1 %}

                                {% if has_no_interest_payments %}
                                  {% set card_icon_color = 'svg-icon-accent' %}
                                {% else %}
                                  {% set card_icon_color = 'svg-icon-text' %}
                                {% endif %}

                                {# If NOT product detail, just include installments alone without link or container #}
                                <div class="js-max-installments-container js-max-installments {% if not product_detail %}item-installments font-small{% endif %}">

                                  {% if has_no_interest_payments %}

                                    <div class="js-max-installments">
                                      {% if product_detail %}

                                        {# Accent color used on product detail #}

                                        {{ "<span class='text-accent font-weight-bold'><span class='js-installment-amount installment-amount'>{1}</span> cuotas sin interés</span> de <span class='js-installment-price installment-price'>{2}</span>" | t(max_installments_without_interests.installment, max_installments_without_interests.installment_data.installment_value_cents | money) }}
                                      {% else %}
                                        {{ "<strong class='js-installment-amount installment-amount'>{1}</strong> cuotas sin interés de <strong class='js-installment-price installment-price'>{2}</strong>" | t(max_installments_without_interests.installment, max_installments_without_interests.installment_data.installment_value_cents | money) }}
                                      {% endif %}
                                    </div>
                                  {% else %}
                                    {% if store.country != 'AR' or product_detail %}
                                      {% set max_installments_with_interests = product.get_max_installments %}
                                      {% if max_installments_with_interests %}
                                        <div class="js-max-installments">{{ "<strong class='js-installment-amount installment-amount'>{1}</strong> cuotas de <strong class='js-installment-price installment-price'>{2}</strong>" | t(max_installments_with_interests.installment, max_installments_with_interests.installment_data.installment_value_cents | money) }}</div>
                                      {% else %}
                                        <div class="js-max-installments" style="display: none;">
                                          {% if product.max_installments_without_interests %}
                                            {% if product_detail %}

                                              {# Accent color used on product detail #}

                                              {{ "<span class='text-accent font-weight-bold'><span class='js-installment-amount installment-amount'>{1}</span> cuotas sin interés</span> de <span class='js-installment-price installment-price'>{2}</span>" | t(null, null) }}
                                              
                                            {% else %}
                                              {{ "<strong class='js-installment-amount installment-amount'>{1}</strong> cuotas sin interés de <strong class='js-installment-price installment-price'>{2}</strong>" | t(null, null) }}
                                            {% endif %}
                                          {% else %}
                                            {{ "<strong class='js-installment-amount installment-amount'>{1}</strong> cuotas de <strong class='js-installment-price installment-price'>{2}</strong>" | t(null, null) }}
                                          {% endif %}
                                        </div>
                                      {% endif %}
                                    {% endif %}
                                  {% endif %}
                                </div>
                              {% endif %}


                              {% if product_detail and installments_info %}
                                <div class="form-row align-items-center align-items-start-md">
                                  {% set has_payment_logos = settings.payments %}
                                  {% if has_payment_logos %}
                                    <ul class="list-inline col-auto" style="margin-top: 0; margin-bottom: 0;">
                                      {% for payment in settings.payments %}
                                          {# Payment methods flags #}
                                          {% if store.country == 'BR' %}
                                            {% if payment in ['visa', 'mastercard'] %}
                                              <li>     
                                                {{ payment | payment_new_logo | img_tag('',{class: 'card-img card-img-small lazyload'}) }}
                                              </li>
                                            {% endif %}
                                          {% else %}
                                              {% if payment in ['visa', 'amex', 'mastercard'] %}
                                                <li>
                                                  {{ payment | payment_new_logo | img_tag('',{class: 'card-img card-img-small lazyload'}) }}
                                                </li>
                                              {% endif %}
                                          {% endif %}
                                      {% endfor %}
                                        <li>
                                          {% include "snipplets/svg/credit-card-blank.tpl" with {svg_custom_class: "icon-inline icon-w-18 icon-2x " ~ card_icon_color ~ ""} %}
                                        </li>
                                    </ul>
                                  {% endif %}
                                  <div>
                                    <a data-toggle="#installments-modal" data-modal-url="modal-fullscreen-payments" class="js-modal-open js-fullscreen-modal-open js-product-payments-container btn-link" style="font-size: 1.5rem; {% if (not product.get_max_installments) and (not product.get_max_installments(false)) %}display: none;{% endif %} text-decoration: none;">
                                      {% set store_set_for_new_installments_view = store.is_set_for_new_installments_view %}
                                      {% if store_set_for_new_installments_view %}
                                          +
                                      {% else %}
                                          {{ "Ver el detalle de las cuotas" | translate }}
                                      {% endif %}
                                    </a>
                                  </div>
                                </div>
                              </div>
                              {% endif %} 



                        {% endif %}
                      {% else %}

                        {# Cart installments #}
                        
                        {% if cart.installments.max_installments_without_interest > 1 %}
                          {% set installment =  cart.installments.max_installments_without_interest  %}
                          {% set total_installment = cart.total %}
                          {% set interest = false %}
                          {% set interest_value = 0 %}
                        {% else %}
                          {% set installment = cart.installments.max_installments_with_interest  %}
                          {% set total_installment = (cart.total * (1 + cart.installments.interest)) %}
                          {% set interest = true %}
                          {% set interest_value = cart.installments.interest %}
                        {% endif %}
                        <div {% if installment < 2 or ( store.country == 'AR' and interest == true ) %} style="display: none;" {% endif %} data-interest="{{ interest_value }}" data-cart-installment="{{ installment }}" class="js-installments-cart-total mt-1">    
                          {{ 'O hasta' | translate }}
                          {% if interest == true %}
                            {{ "<strong class='js-cart-installments-amount'>{1}</strong> cuotas de <strong class='js-cart-installments installment-price'>{2}</strong>" | t(installment, (total_installment / installment) | money) }}
                          {% else %}
                            {{ "<span class='js-cart-installments-amount'>{1}</span> cuotas sin interés de <span class='js-cart-installments installment-price'>{2}</span>" | t(installment, (total_installment / installment) | money) }}
                          {% endif %}
                        </div>
                      {% endif %}



                      {# Max Payment Discount #}

                      {% if product_detail and hasDiscount %}
                        <div class="mb-2">
                          <span><strong class="text-accent">{{ product.maxPaymentDiscount.value }}% {{'de descuento' | translate }}</strong> {{'pagando con' | translate }} {{ product.maxPaymentDiscount.paymentProviderName }}</span>
                        </div>
                      {% endif %}
                          

                      </div>
                    </div>





                      {# Product description #}

                      {% if product.description is not empty %}
                          <div class="js-product-description product-description user-content" data-store="product-description-{{ product.id }}" style="padding-top: 2vh; max-height: unset;">
                              {{ product.description }}
                              <div class="js-view-description product-description-more" style="display: none; height: unset;">
                                  <div class="btn-link mt-4" style="text-decoration: none;">
                                      {% if settings.positive_color_background %}
                                          {% set view_description_icon_class = 'icon-inline icon-lg svg-icon-invert ml-1' %}
                                      {% else %}
                                          {% set view_description_icon_class = 'icon-inline icon-lg svg-icon-text ml-1' %}
                                      {% endif %}
                                  </div>
                              </div>
                          </div>
                      {% endif %}



                          <div class="delivery-grid">

                            <div class="d-flex">
                              <img src="https://i.ibb.co/LS1VsjB/envios.png" style="height: 5vh; margin-right: 1vw;">

                              <div>
                                <p><strong>Envio Gratis</strong></p>
                                <p>Domicilio Céspedes 3146 piso 1 , Colegiales - Atención de Lun. a Vie. de 13 a 18 con previo aviso</p>
                              </div>
                            </div>
                          </div>


                      {# Product form, includes: Variants, CTA and Shipping calculator #}

                      <div class="js-fixed-product-form-placeholder" style="display: none;">
                      </div>
                      <form id="product_form" class="js-product-form js-fixed-product-form" method="post" action="{{ store.cart_url }}" data-store="product-form-{{ product.id }}">
                          <input type="hidden" name="add_to_cart" value="{{product.id}}" />

                          {# Fixed add to cart on scroll #}

                          <div class="js-product-form-toggle row">
                              <div class="col price-container mb-3 d-md-none" data-store="product-price-{{ product.id }}">
                                  <span class="d-inline-block">
                                      <span class="js-price-display" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %}>{% if product.display_price %}{{ product.price | money }}{% endif %}</span>
                                  </span>
                                  <span class="d-inline-block">
                                    <span id="compare_price_display" class="js-compare-price-display price-compare" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %} style="display:block;"{% endif %}>{% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}</span>
                                  </span>
                              </div>
                              {% if product.variations %}
                                  <div class="col-auto d-md-none">
                                      {% include "snipplets/svg/chevron-down.tpl" with {svg_custom_class: "js-product-form-toggle-icon icon-inline icon-lg"} %}
                                      <span class="js-product-form-toggle-icon" style="display: none;">
                                        {% include "snipplets/svg/chevron-up.tpl" with {svg_custom_class: "icon-inline icon-lg"} %}
                                      </span>
                                  </div>
                              {% endif %}
                          </div>
                        

                          {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                          {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                          {# Add to cart CTA #}

                          <div class="mb-4" style="margin-top: 2vh;">

                              <input type="submit" style="background-color: #B2CC5E; border: none;" class="js-addtocart js-prod-submit-form btn btn-block {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-store="product-buy-button"/>

                              {# Fake add to cart CTA visible during add to cart event #}

                              {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-block mb-4"} %}

                              <div class="js-added-to-cart-product-message mb-3 mt-3 text-center text-md-left" style="display: none;">
                                  {{'Ya agregaste este producto.' | translate }}<a href="#" class="js-modal-open js-fullscreen-modal-open btn btn-link ml-2 pl-0 py-0" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart">{{ 'Ver carrito' | translate }}</a>
                              </div>

                          </div>
                      </form>

                  </div>

                  <div class="js-product-detail-bottom product-detail-bottom">
                      {# Define contitions to show shipping calculator and store branches on product page #}

                      {% set show_product_fulfillment = settings.shipping_calculator_product_page and (store.has_shipping or store.branches) and not product.free_shipping and not product.is_non_shippable %}

                      {% if show_product_fulfillment %}

                          {# Shipping calculator and branch link #}

                          <div id="product-shipping-container" class="product-shipping-calculator container-invert list mb-5" {% if not product.display_price or not product.has_stock %}style="display:none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">

                              {# Shipping Calculator #}
                              
                              {% if store.has_shipping %}
                                  {% include "snipplets/shipping/shipping-calculator.tpl" with {'shipping_calculator_variant' : product.selected_or_first_available_variant, 'product_detail': true} %}
                              {% endif %}

                              {% if store.branches %}
                                  
                                  {# Link for branches #}
                                  {% include "snipplets/shipping/branches.tpl" with {'product_detail': true} %}
                              {% endif %}
                          </div>
                      {% endif %}

                      {# Product share #}

                      {% include 'snipplets/social/social-share.tpl' %}
                  </div>

                  {# Product payments details #}

                  {% include 'snipplets/payments/payments.tpl' %}

              </div>

            </div>
        </div>
        <div id="reviewsapp"></div>
    </div>  
</div>

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}




<style>
  .box {
    margin: 3vh auto;
  }

  .js-tab-link.tab-link {
    text-decoration: none;
  }

  .box img {
    object-fit: contain;
    border: none;
    height: 20vh;
  }

  .js-tabs-content {
    text-align: center;
  }

  #installments-modal {
    display: flex;
    z-index: 1000000;
    flex-direction: column;
    width: 40vw;
    border-radius: 40px;
    transform: translate(75%, 1px);
  }

  .text-accent.font-weight-bold {
    color: black !important;
  }

  .mb-2 strong.text-accent {
    color: black !important;
  }

  .btn-link:hover {
    color: black;
  }

  .form-control-container .form-control.js-quantity-input.form-control-quantity.text-center.form-control-inline {
    padding: 2.15vh 0;
  }

  .carousel-item {
    border-radius: 10px;
    height: 80vh !important;
  }

  .nav-list-link {
    text-decoration: none;
  }

  .svg-icon-accent {
    fill: black !important;
  }

  .card-img {
    margin: 0 5px;
  }

  .product-slider-image {
    height: 100%;
  }

  // .serif {
  //   font-family: 'Roboto Serif', serif;
  // }

  // .sans-serif {
  //   font-family: 'Roboto', sans-serif;
  // }

  .form-select, .form-control-container input {
    background: white !important;
    box-shadow: 2px 2px 5px rgba(0,0,0,0.25);
    border-radius: 10px;
  }

  .form-select-icon, .js-quantity-up,  .js-quantity-down {
    border-radius: 10px;
  }

  .form-group {
    display: grid;
    grid-template-columns: 1fr 4fr;
  }

  .form-label {
    display: flex;
    align-items: center;
    font-weight: bolder;
    margin-right: 0.5vw;
    margin-bottom: 0 !important;
    text-transform: unset;
  }

  .js-quantity-down {
    margin-left: 5.25vw;
  }

  .form-select, .form-control-container {
    width: 40%;
  }

  .form-group .form-select-icon {
    right: 10vw;
  }

  .js-quantity .form-control-container {
    width: 3vw;
  }

  .js-quantity-up {
    position: absolute;
    right: 10.75vw;
  }

  .form-group .js-quantity {
    margin-left: -6vw;
  }

  .list-inline.col-auto {
    display: flex;
    align-items: center;
  }

  .section-single-product {
    display: grid;
    grid-template-columns: 2fr 3fr;
  }

  .delivery-grid {
    display: grid;
    grid-template-columns: 1fr;
    padding: 2vh 0;
    border-bottom: 1.5px solid black;
    border-top: 1.5px solid black;
  }

  .info-top {
    margin: 3vh 0;
  }

  @media only screen and (max-width: 450px) {
    .section-single-product {
      grid-template-columns: 1fr;
    }

    .delivery-grid {
      grid-template-columns: 1fr;
    }

    .payment-info {
      display: grid !important;
    }

    .plant {
      height: 18vh !important;
      width: 13vw !important;
    }

    .form-select {
      width: 70%;
    }

    .form-control-container input {
      width: 70%;
    }

    .form-label {
      margin-right: 2vw;
    }

    .form-group .form-select-icon {
      right: 9vw;
    }

    .js-quantity .form-control-container {
      width: 15vw;
    }

    .info-top {
      margin-top: 16vh;
      padding: 0 4vw;
    }

    #installments-modal {
      width: 100vw;
      transform: unset;
    }

    .js-tab-group.tab-group {
      display: flex;
      flex-wrap: wrap;
    }

  }

</style>

<script>
  document.querySelector(".carousel-item").classList.add("active")
</script>