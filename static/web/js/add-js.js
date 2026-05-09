$(document).on("click", 'button[data-id="add-to-wishlist"]', function() {
    let is_login = $(this).hasClass("proceed_to_login")

    let id = $(this).attr("data-pk");
    var url = $(this).attr("href");
    $parent = $(this).parents('div[data-class="product"]');    
    $wishlist = $(this).parents("#best-seller.whishlist-item");
//    var wishEmpty = $(this).('#wish-empty');
//    var wishFilled = $(this).('#wish-filled');

    let is_Notlogin = $(this).hasClass("proceed_to_login")
    if(is_Notlogin == true){
        $("#sign-ip").show();
        $("#SignIn").show();
    }else{

    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            product_variant:id
        },

        success: function (data) {
              var imgAdded = $('span#'+id).find('img').attr("data-path");
              var imgEmpty = $('span#'+id).find('img').attr("data-path-empty");

              if(data['status']=='added'){
                    $('span#'+id).find('img').attr("src",imgAdded);


              } else if(data['status']=='null'){
                       document.getElementById("SignIn").style.display = "block";
                       document.getElementById("SignUp").style.display = "none";
                       $('#sign-ip').css({
                            'display':'flex'
                        });
              }  else if(data['status']=='not_in_batch'){
                       var title = "Not Available";
                        var message = "Product is not available in selected Zone";
                        swal(title, message, "error");
              }
              else if (data['status']=='removed') {
                if ($wishlist.length > 0) {
                    $('span#'+id).parent().remove();
                }
                $('span#'+id).find('img').attr("src",imgEmpty);
              }
               else {
                   $('span#'+id).find('img').attr("src",imgEmpty);
              }

        },

        error: function (data) {
            var title = "An error occurred";
            var message = "An error occurred. Please try again later.";
            swal(title, message, "error");
        }
    });
}
});

$(document).on("click", '.add-to-cart', function() {
    let $this = $(this);
    let id = $this.attr("data-pk");
    var url = $this.attr("href");

    $parent = $this.parents('div[data-class="product"]');

    let is_Notlogin = $this.hasClass("proceed_to_login")

    var e = document.getElementById("id_my_pincode");
    var zone = e.value;

    if(is_Notlogin == true){
        $("#sign-ip").show();
        $("#SignIn").show();
    }
    else if(zone == 0)
    {
        $('.myPiccodePopup').click()
    }
    else{
        var qty = $this.attr("data-qty");

        $.ajax({
            type: "GET",
            url: url,
            dataType: "json",
            data: {
                product_variant:id,
                qty: qty
            },

            success: function (data) {

                let status = data['status'];

                if(status=='not_in_batch'){
                    var title = "Product not available";
                    var message = "Product is not available in your area!";
                    swal(title, message, "error");

                } else if(data['status']=='different-location'){
                    var title = "Different Location";
                    var message = data["message"];
                    swal(title, message, "error");

                } else if (status == 'added'){
                    $('#single-product div.apply-cart:not(.wholesale-cart)').attr('style', 'display: none !important');
                    $('#single-product div.my-cart').attr('style', 'display: block !important');

                    //                      shows the quantity button
                    $('#single-product .right-box .bottom div.quantity').attr('style', 'display: flex !important');
                    $('input#theInput').val(data['qty']);

                    //                    updating links to plus and minus buttons
                    $('#single-product div.quantity input#minus').attr('data-pk', id);
                    $('#single-product div.quantity input#plus').attr('data-pk', id);

                    $('.bottom .quantity').addClass("flex");
                    $('.bottom .apply:not(.wholesale-cart)').addClass("none");

                    var pageURL = $(location).attr("href");
                    // $('#MyCart').load(pageURL + );
                    $("#MyCart").load(location.href + " div#myCartChildren");
                    $(".cart-icon a span").remove();

                    $(".cart-icon a").append(`<span>${data['cart_count']}</span>`);
                }

            },

            error: function (data) {
                var title = "An error occurred";
                var message = "An error occurred. Please try again later.";
                swal(title, message, "error");
            }
        });
    }
});

//cart incrememt
$(document).on("click", '.bottom .plus', function() {
    let id = $(this).attr("data-pk");
    var url = $(this).attr("href");

    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            product_variant:id
        },

        success: function (data) {
            $(`.${id} .input-text`).val(data['qty'])
            $("#MyCart .price-details-MainContainer").load(location.href + " .price-details-MainContainer");
        },

        error: function (data) {
            var title = "An error occurred";
            var message = "An error occurred. Please try again later.";
            swal(title, message, "error");
        }
    });
});

//cart decrement
$(document).on("click", '.bottom .minus', function() {

    let id = $(this).attr("data-pk");
    var url = $(this).attr("href");

    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            product_variant:id
        },

        success: function (data) {
            $(`.${id} .input-text`).val(data['qty'])
            $("#MyCart .price-details-MainContainer").load(location.href + " .price-details-MainContainer");
            if(data['qty'] == 0){
                window.location.reload();
            }

        },

        error: function (data) {
            var title = "An error occurred";
            var message = "An error occurred. Please try again later.";
            swal(title, message, "error");
        }
    });
});

// $('.minus-cart').click(function (e) {
$(document).on("click", '.minus-cart', function(e){
    e.preventDefault();
    var val = 0
    let $this = $(this);
    decrement_cart($this, val)

    if($("#modal-cart .cart-items").length == 0){
        window.location.reload();
    }
});

// $('.plus-cart').click(function (e) {
$(document).on("click", '.plus-cart', function(e){
    e.preventDefault();
    var $this = $(this);
    var val = 0
    increment_cart($this, val)
});

// $('.plus-checkout').click(function (e) {
$(document).on("click", '.plus-checkout', function(e){
			e.preventDefault();
			var $this = $(this);
			var val = 0
            increment_cart_checkout($this, val)
            // $(".amt1").load(location.href + " h6");
            // $(".amt1").load(location.href + " .total-amount");
});

// $('.minus-checkout').click(function (e) {
$(document).on("click", '.minus-checkout', function(e){
    e.preventDefault();
    var $this = $(this);
    var val = 0
    decrement_cart($this, val)
    // $(".amt").load(location.href + " .amt");
    // $(".amt1").load(location.href + " .amt1");
});

$("#customerAddress").on('click', 'li', function () {
    $("#customerAddress li.address-active").removeClass("address-active");
    $(this).addClass("address-active");
});

$('#proceed').click(function (e) {
    e.preventDefault();
    var element = $( "#customerAddress" ).find( "li.address-active" );
    var url = element.attr('data-url');
    var pk = element.attr('data-pk');
    set_adress_and_proceed(url,pk);
});


$(document).on('click', '.removeCart', function (e) {
    e.preventDefault();
    var $this = $(this);
    remove_cart($this,"cart");
});

$('.remove-cart-checkout').click(function (e) {
    e.preventDefault();
    var $this = $(this);
    remove_cart($this,"checkout");
});



$('#cntn-shopping').click(function(){
    var redirectUrl = $(this).attr('data-url');
    var actionUrl = $(this).attr('data-action-url');
    clearCookiesAndContinueShopping(redirectUrl, actionUrl)
});

$(".productDetailsFooter .rightSide a ").click(function (e) {
    e.preventDefault();
    var pk = $(this).attr('data-pk');
    $('.'+pk).show();
});

$(".ProductDeliveryDetails .leftSide a ").click(function (e) {
    e.preventDefault();
    var pk = $(this).attr('data-pk');
    var product_pk = $(this).attr('item-pk');
    $('.'+pk+'review').show();
    $('.hide-products').each(function() {
        $(this).hide();
    });    
    $('.'+product_pk+'product-review').show();
});

$(".cancelButton-Row a button").click(function (e) {
    e.preventDefault();
    var pk = $(this).attr('data-pk');
    $('.'+pk).show();
});

$(".pincode-submit").click(function (e) {
    e.preventDefault();
    var url = $(this).attr('data-url');
    var value = $('#id_my_pincode').val()
    setPincode(url, value);
});

$(document).on("click", '.bookNowButton', function(e) {
    e.preventDefault();

    var url = $(this).attr('data-url');
    var product_pk = $(this).attr('data-pk');

    swal({
        title: "Are you sure?",
        // text: "Your will not be able to recover this imaginary file!",
        type: "warning",
        showCancelButton: true,
        confirmButtonClass: "btn-danger",
        confirmButtonText: "Yes!",
        confirmButtonColor: '#8CD4F5',
        closeOnConfirm: false
      },
      function(){
        swal("Booked!", "Successfully", "success");
        bookProduct(url, product_pk);
      });

});

// $(".add-to-cart-button").click(function (e)
$(document).on("click", '.add-to-cart-button', function(e   ){
    e.preventDefault();
    var url = $(this).attr('href');
    var product_pk = $(this).attr('data-pk');

    let is_no_zone = $(this).hasClass("select-your-pincode")
    let is_Notlogin = $(this).hasClass("proceed_to_login")

    var e = document.getElementById("id_my_pincode");
    var zone = e.value;


    if(is_Notlogin == true){
        $("#sign-ip").show();
        $("#SignIn").show();
    }
    else if(zone == 0)
    {
        $('.myPiccodePopup').click()
    }
    else{
        if(is_no_zone == true){
            // document.getElementById("SelectPincode").style.display = "block";
            $('.myPiccodePopup').click()
        }else{

            addToCart(url,product_pk,$(this))
        }

    }

});

$("#cancelOrderButton").click(function (e) {
    e.preventDefault();
    var url = $(this).attr('href');
    var order_pk = $(this).attr('data-pk');
});

$(document).ready(function() {
    $('.tab2').addClass('disabled-tab'); //initially disabled the payment tab
})
$(document).ready(function() {
    $('#proceed').on('click', function() {
      // Check if there are any addresses
      if ($('#customerAddress li').length === 0) {
        message = "Please add an address before proceeding";
        $("#snackbar").html(message);
        snackBarFunction(message);
        return;
      }

      // Check if a default address is selected
      if (!$('#customerAddress li.address-active').length) {
        message = "Please choose a default address";
        $("#snackbar").html(message);
        snackBarFunction(message);
        return;
      }
    });
  });
$(document).ready(function() {
// Get today's date
    var today = new Date();
    // Format the date as dd mm yyyy
    var formattedDate = ('0' + today.getDate()).slice(-2) + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + today.getFullYear();
    // Set the default value of the date picker input element to today's date
    $("#datepicker").val(formattedDate);
});
function DeliveryDateChecker(){
    let language = $('input[name="current-language"]').val();
    let is_normal = $('#normal').is(":checked");
    let is_express = $('#express').is(":checked");

    if (is_normal){
        let date = $("#datepicker").val()
        if (!date){
            message = language=='ar'?"يرجى تحديد تاريخ التسليم قبل المتابعة":"Please specify the delivery date before proceeding";
            $("#snackbar").html(message);
            snackBarFunction(message);
            return false
        }

        let timeslot = $("#timeslot").val()
        if (!timeslot){
            message = language=='ar'?"الرجاء تحديد فترة زمنية للتسليم قبل المتابعة":"Please select a time period for delivery before proceeding";
            $("#snackbar").html(message);
            snackBarFunction(message);
            return false
        }
        if (date && timeslot) {
            $('.tab2').removeClass('disabled-tab'); //if the time slot is selected removed .disabled-tab
        } else {
            $('.tab2').addClass('disabled-tab'); 
        }
    }else{
        let date = new Date();
        let hour = date.getHours();

        if (hour <= 8 || hour >= 22){
            message = language=='ar'?"لا يمكنك تقديم طلب في التوصيل السريع خلال الفترة من 10 مساءً إلى 8 صباحًا":"You cannot place an order in express delivery during the period from 10 pm to 8 am";
            $("#snackbar").html(message);
            snackBarFunction(message);
            return false
        }
    }
    if (is_express){
        $('.tab2').removeClass('disabled-tab');
    }
    return true
}
$("#payment .heading li.tab2").click(function () {
    // Check if the date and time slots are selected using DeliveryDateChecker
    if (DeliveryDateChecker()) {
        
        $("#payment .heading li").removeClass("active");
        $(this).addClass("active");
        $("#payment .tab-click").show();
        $("#address").hide();
        $("#payment .tab-click").slideDown("slow", function () {});
    }
    else {
        $('.tab2').addClass('disabled-tab');
    }
});

//procedd to payment from time slot
$("#validate").click(function(){
    if (DeliveryDateChecker()) {
        var $this = $(this);
        validateOrder($this);
    } 
});


$(document).on('click', '.voucher-apply-button', function(e){
    e.preventDefault();
    var button = $(this)
    var pk = $(this).attr('data-pk');
    var url = $(this).attr('data-url');

    apply_coupon(pk,url,button);
});

$(document).on('click', '.voucher-remove-button', function(e){
    e.preventDefault();
    var url = $(this).attr('data-url');
    remove_coupon(url);
});

$(".productVariant123").change(function(){
    var dop = $('.productVariant123').val();
    url = $("."+dop).attr('data-url');

    $(".content").load(url + " .content");
    $(".changable").load(url + " .changable");
    $("#single-product .right-box .top .right-card").load(url + " #single-product .right-box .top .right-card");

    // $(".right-box .content").load(url + " .right-box .bottom");
});

$(document).on("click", '.custom-select', function() {
    let value = $(".custom-select select").val();

    new_url = $(`option[value="${value}"]`).attr('data-goto');
    location.assign(new_url)

    // let url = $("."+value).attr('data-url');
    // update_product_variant(url, value);
});

$(document).on("click", '.ticket-submit', function(e) {
   e.preventDefault();
   url = $(this).attr('data-url');
   value = $("#description").val();
   title = $("#issue_title").val();

   newIssue(url,value,title);
});

$(document).on("click", '.apply-wallet-button', function(e) {
    e.preventDefault();
    url = $(this).attr('data-url');
    var input_field = $('.input-amount input').css('display')
    var point = $('.input-amount input').val()

    $('.input-amount input').css('display','block')

    if (input_field == 'block'){
        applyWalletAmount(url,this,point);
    }
});

$("#datepicker").on("change",function(){
    var date = $(this).val();
    url = $(this).attr('data-url')
    getTimeSlots(date,url);
});

$(document).on("change", '#checkOutproduct .container-side .checkOutContainer .timeSelect .timeInput', function() {
    $(this).addClass("active").siblings().removeClass('active');

    // getting the time slot pk and proceed to payment
    var time_slot_pk = $(this).attr('data-time-pk');
    $('#timeslot').val(time_slot_pk);
});

$(document).on("click", '.rating-product-submit', function(e) {
   e.preventDefault();
   url = $(this).attr('data-url');
 
   productId = $(this).attr('data-product-id');


   $parent = $(this).parents('.ReviewProduct');

   review = $parent.find('.product-review').val();
   rating = $parent.find("input[name='rating']:checked").val();

   postRating(url,productId,review, rating);
});

$(document).on("click", '.search-button', function(e) {
   e.preventDefault();
   url = $(this).attr('data-url');

   $parent = $(this).parents('#spotlight');

   query = $('.search-query').val();

   location.href = url+"?query="+query;
});

$(document).on("click", '.cancel-order-popup', function(e) {
   e.preventDefault();

    var pk = $(this).attr('data-pk');
    var url = $(this).attr('data-url');

    getProductDetails(url,pk);
});

$('#cancelreason').change(function() {
    rejected_reason = $('#cancel-review').val();

    selected_value = $(this).find(":checked").val();
    if (selected_value == 'others'){
        $('.SideTextareaMainContainer').css({
            'display':'block',
        });
    } else {
        $('.SideTextareaMainContainer').css({
            'display':'none',
        });
    }
});

$(document).on("click", '.return-product-button', function(e) {
   e.preventDefault();

    var pk = $(this).attr('data-pk');
    var url = $(this).attr('data-url');

    returnProduct(url,pk);
});

$(document).on("click", '.cancel-order-buttton', function(e) {
   e.preventDefault();

    var pk = $(this).attr('data-pk');
    var url = $(this).attr('data-url');

    cancelOrder(url,pk);
});
$(document).on("click", '.cancel-order-item-button', function(e) {
    e.preventDefault();
 
     var pk = $(this).attr('data-pk');
     var url = $(this).attr('data-url');
 
     cancelOrderItem(url,pk);
 });

//functions starts

function decrement_cart($selector, val) {
    var parent = $selector.parents('.cart-items');
    var id = parent.find('.nameArea-Left').attr('data-pk');
    var url = parent.find('.nameArea-Left').attr('href');

   $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            product_variant:id
        },

        success: function (data) {
            parent.find('.input-text').val(data['qty']);
            $(`.${id} .input-text`).val(data['qty']);
            if(data['qty'] == 0){
                parent.remove();
                $(`li.${id}`).remove();
            }
            if ($('#payment').length > 0){
                
            }
            
            // updating cart overlay
            var total = data['total'];
            if(total == 0){
                window.location.reload()
            }
            $('.total-amount').html(total)
            $('.item-total').html(total)
            $("#MyCart .price-details-MainContainer").load(location.href + " .price-details-MainContainer");
            $(`li.${id} input[type="text"]`).val(data['qty']);
            $("#checkOutproduct .contents").load(location.href + " #checkOutproduct .contents");
            $("#address .contents").load(location.href + " #address .contents");
            $("#payment_tab .contents").load(location.href + " #payment_tab .contents");
            cart_count = parseInt($(".cart-icon a span").html())
            if (cart_count > 1) {
                $(".cart-icon a span").html(cart_count-1)
            }
            else {
                $(".cart-icon a span").remove();
            }
        },

        error: function (data) {
            var title = "An error occurred";
            var message = "An error occurred. Please try again later.";
        }
    });
}

function increment_cart($selector, val) {
    var parent = $selector.parents('.cart-items');
    var id = parent.find('.plus-cart').attr('data-pk');
    var url = parent.find('.plus-cart').attr('href');

   $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            product_variant:id
        },

        success: function (data) {
            parent.find('.input-text').val(data['qty']);
            $(`.${id} .input-text`).val(data['qty']);
//             location.reload();
//                 updating cart overlay
             $("#MyCart .price-details-MainContainer").load(location.href + " .price-details-MainContainer");

        },

        error: function (data) {
            var title = "An error occurred";
            var message = "An error occurred. Please try again later.";

        }
    });
}

function increment_cart_checkout($selector, val) {
    var parent = $selector.parents('.cart-items');
    var id = parent.find('.plus-checkout').attr('data-pk');
    var url = parent.find('.plus-checkout').attr('href');

   $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            product_variant: id
        },

        success: function (data) {
            parent.find('.input-text').val(data['qty']);
            parent.find('.qty').val(data['qty'])
            var total = data['total'];
            $('.total-amount, .item-total').html(total)
            $("#MyCart .price-details-MainContainer").load(location.href + " .price-details-MainContainer");
            $(`li.${id} input[type="text"]`).val(data['qty']);
            $("#checkOutproduct .contents").load(location.href + " #checkOutproduct .contents");
            $("#address .contents").load(location.href + " #address .contents");
            $("#payment_tab .contents").load(location.href + " #payment_tab .contents");
        },

        error: function (data) {
            var title = "An error occurred";
            var message = "An error occurred. Please try again after refreshing.";
        }
    });
}

function set_adress_and_proceed(url,pk){

     $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            address:pk
        },

        success: function (data) {
              let status = data['status'];

              if(status == 'true'){
                $('#payment .heading li').removeClass('active')
                $('.tab3').addClass('active')

                $("#address").hide();
                $("#payment #checkOutproduct").slideDown("slow", function () {});

              } else {
                $('#addressError').css({'display': 'block'});
              }
        },

        error: function (data) {
            var title = "An error occurred";
            var message = "An error occurred. Please try again later.";

        }
    });

}

function remove_cart($selector,section) {
    var parent = $selector.parents('.cart-items');
    var id;
    var url;

    if(section=='cart'){
        id = parent.find('.removeCart').attr('data-pk');
         url = parent.find('.removeCart').attr('data-url');
    } else if (section=='checkout'){
         id = parent.find('.remove-cart-checkout').attr('data-pk');
         url = parent.find('.remove-cart-checkout').attr('href');
    }

   $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            pk:id
        },

        success: function (data) {

              var result = data['status'];
              var total = data['total'];
              if(result=='true'){
                parent.css({"display":"none"});
                if(total == 0){
                    $(".price-details-new, .cart-list").css("display", "none");
                    window.location.reload()
                }
                $(".cart-icon a span").remove();
                if (data['cart_count']>0){
                    $(".cart-icon a").append(`<span>${data['cart_count']}</span>`);
                }
                if(section=='cart'){
                    $(".price-details-data").load(location.href + " .price-details-data");

                } else if (section=='checkout'){
                     $(".amt1").load(location.href + " .amt1");
                }

              }

        },

        error: function (data) {
            var title = "An error occurred";
            var message = "An error occurred. Please try again later.";
        }
    });
}



function setPincode(url,value){

     $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            zone:value
        },

        success: function (data) {
              let status = data['status'];

              if(status == 'true'){
                   $('#id01').css({"display":"none"});
                   window.location.reload();
              } else {

              }
        },

        error: function (data) {
            var title = "An error occurred";
            var message = "An error occurred. Please try again later.";

        }
    });

}

function bookProduct(url,product_pk){

     $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            product:product_pk
        },

        success: function (data) {
              status = data['status'];

              if(status == 'true'){
                $(".bookNowButton").html('Booked !');
              } else {

              }
        },

        error: function (data) {
            var title = "An error occurred";
            var message = "An error occurred. Please try again later.";
            swal(title, message, "error");
        }
    });

}

function addToCart(url,product,$this){

    var image = $this.attr('data-image')

    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            product_variant:product
        },

        success: function (data) {
            if(data['status']=='null'){
                document.getElementById("SignIn").style.display = "block";
                $('#sign-ip').css({
                    'display':'flex'
                });

            } else if(data['status']=='not_in_batch'){
                var title = "Not Available";
                var message = "Product is not available in selected Zone";
                swal(title, message, "error");
            } else if(data['status']=='different-location'){
                var title = "Not Available";
                var message = data["message"];
                swal(title, message, "error");
            } else{
                $this.find('img').attr('src',image);
                var pageURL = $(location).attr("href");
                $(".cart-icon a span").remove();
                $(".cart-icon a").append(`<span>${data['cart_count']}</span>`);

                // $('#MyCart').load(pageURL + );
                $("#MyCart").load(location.href + " div#myCartChildren");

                

              }
            $("header div.right ul li.my-cart span ").text(data["cart_count"])

        },

        error: function (data) {
            var title = "An error occurred";
            var message = "An error occurred. Please try again later.";
            swal(title, message, "error");
        }
    });
}

function apply_coupon(pk,url,button){

    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            pk:pk
        },

        success: function (data) {
              if(data['status']=='true'){
                    var amt = data['total_amt']
                    var percent_amt = data['percent_amt']

                    $('.coupon-amt').html(percent_amt);
                     $('.total-amt .total-td').html(data['total_amt']);


                    $(".voucher-apply-button").text("Apply");
                    $(button).text("Applied");
                    $(".voucher-apply-button").removeClass("applied");
                    $(button).addClass("applied");

                    $('.voucher-remove-button').show()

              } else if (data['status']=='false'){
                    var title = "An error occurred";
                    var message = "Your are not eligible for this coupon";
                    swal(title, message, "error");
              }else {
                    var title = "An error occurred";
                    var message = "An Error Occoured";
                    swal(title, message, "error");
              }
        },

        error: function (data) {
            var title = "An error occurred";
            var message = data;
            swal(title, message, "error");
        }
    });
}

function remove_coupon(url){
    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {},

        success: function (data) {
            if(data['status']=='true'){
                $(".voucher-apply-button").text("Apply");
                $(".voucher-apply-button").removeClass("applied");

                $('.voucher-remove-button').hide()

                $(".price-details-MainContainer").load(location.href + " .price-details-MainContainer");
            }else {
                var title = "An error occurred";
                var message = "An Error Occoured";
                swal(title, message, "error");
            }
        },

        error: function (data) {
            var title = "An error occurred";
            var message = data;
            swal(title, message, "error");
        }
    });
}

function update_product_variant(url,value){

    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            pk:value
        },

        success: function (data) {
              if(data['status']=='true'){
                var is_cart = data['cart'];
                cart_qty = data['cart_qty']
                product_pk = data['pk'];
                is_wishlist =  data['is_wishlist'];
                let image = data['image'];
                stock = data['stock'];


                var wishEmpty = $(".right-card span.wishlist button img").attr("data-path-empty");
                var wishFilled = $(".right-card span.wishlist button img").attr("data-path");

                $(".right-card span.wishlist button").attr('data-pk',product_pk);
                $(".right-card span.wishlist").attr('id',product_pk);
                $('.product-name').html(data['name']);
                $('.product-mrp').html("₹" + data['retail_price'] + " /-");
                $('.product-cross-mrp').html("₹" + data['mrp'] + " /-");
                $(".variant-image img").attr('src',"/media/"+data['image']);

                //  if product exists in cart
                if(is_cart=="True"){
                    $('#single-product div.apply-cart').attr('style', 'display: none !important');
                    $('#single-product div.book-now-button').attr('style', 'display: none !important');

                    //  shows the quantity button
                    $('#single-product .right-box .bottom div.quantity').attr('style', 'display: flex !important');
                    $('#single-product input#theInput').val(cart_qty);

                    $(".apply.my-cart").addClass("block");
                    $(".apply.my-cart").removeClass("none");

                    //  updating links to plus and minus buttons
                    $('#single-product div.quantity input#minus').attr('data-pk', product_pk);
                    $('#single-product div.quantity input#plus').attr('data-pk', product_pk);

                } else {

                   if(stock=="0"){
                        $('#single-product div.apply-cart').attr('style', 'display: none !important');
                        $('#single-product div.book-now-button').attr('style', 'display: flex !important');
                    } else {
                       $('#single-product div.apply-cart').attr('style', 'display: block !important');
                        $('#single-product div.book-now-button').attr('style', 'display: none !important');
                    }
                    $(".apply.my-cart").removeClass("block")
                    $(".apply.my-cart").addClass("none")

                    //   hides the quantity button
                   $('#single-product .right-box .bottom div.quantity').attr('style', 'display: none !important');

//                   new cart button
                    $('#single-product div.apply-cart button').attr('data-pk',product_pk);

//                   plus and minus button update pk
                    $('#single-product div.quantity input#minus').attr('data-pk', product_pk);
                    $('#single-product div.quantity input#plus').attr('data-pk', product_pk);
                }
                if (image){
                    $('#single-product .left-box .left-box-single-pic img').attr('src', image)
                }

                if(is_wishlist=="True"){
                    $(".right-card span.wishlist button img").attr('src',wishFilled);
                } else {
                    $(".right-card span.wishlist button img").attr('src',wishEmpty);
                }

              } else {}
        },

        error: function (data) {
            var title = "An error occurred";
            var message = data;
            swal(title, message, "error");
        }
    });
}

function newIssue(url,value){

    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            description:value
        },

        success: function (data) {
              status = data['status']

              if(status=='true'){
                 var title = "Submitted Successfully";
                var message = "Ticket Submitted Successfully";
                swal(title, message, "success");
             }
        },

        error: function (data) {
            var title = "An error occurred";
            var message = data;
            swal(title, message, "error");
        }
    });
}

function applyWalletAmount(url,button,point){

    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            point:point,
        },
        success: function (data) {

            status = data['status']

              $('.wallet-error-text').attr('style','display: none !important');


              if(data['state']=='exceed'){
                $('.wallet-error-text').attr('style','display: block !important');
              }

              if(status=='true'){
                $('.total-amt .total-td').html(data['total']);
                // $(button).addClass("applied");
                $('#wallet-amount').html(data['value']);
             }
        },

        error: function (data) {
            var title = "An error occurred";
            var message = data;
            swal(title, message, "error");
        }
    });
}

function getTimeSlots(date){
    var deliveryDate = new Date(date.replace( /(\d{2})-(\d{2})-(\d{4})/, "$2/$1/$3")); //dd-mm-YYYY
    var today = new Date();

    today = today.setHours(0,0,0,0)

    if(deliveryDate >= today) {
        $.ajax({
            type: "GET",
            url: url,
            dataType: "json",
            data: {
                date:date
            },

            success: function (data) {

                var slots;

                slots = data['slots']
                //   json_slots = JSON.parse(slots)

                $(".timeSelect").empty();

                if (slots.length == 0){
                    $("#not_slots_available").show()
                }
                else{
                    $("#not_slots_available").hide()
                    for (var i = 0; i < slots.length; i++) {

                        $(".timeSelect").append(
                            `<div class="timeInput" data-time-pk="${slots[i]['pk']}">
                            <h6>${slots[i]['name']}</h6>
                            <input name="fav_language" type="radio" value="">
                            </div>`
                        );
                    }
                }

            },

            error: function (data) {
                var title = "An error occurred";
                var message = data;
                swal(title, message, "error");
            }
        });
    }
    else{
        var title = "Invalid Date";
        var message = "Please select a date that is today or in the future.";
        swal(title, message, "error");
    }
}

function clearCookiesAndContinueShopping(redirectUrl, actionUrl){

    $.ajax({
        type: "GET",
        url: actionUrl,
        dataType: "json",
        data: {

        },
        success: function (data) {
            window.location.replace(redirectUrl);
        },

        error: function (data) {
            var title = "An error occurred";
            var message = data;
            swal(title, message, "error");
        }
    });
}

function postRating(url,productId,review,rating){

    // rating = $("input[name='rating']:checked").val();

    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            rating : rating,
            review : review,
            // order_id : orderId,
            product_id:productId
        },

        success: function (data) {
              status = data['status']
              message = data['message']
              title = data['title']

              if(status=='true'){
                //  var title = "Rated Successfully";
                // var message = "Ratings Submitted Successfully";
                swal({
                    title: title,
                    text: message,
                    type:"success",
                    confirmButtonClass:"btn-primary"
                }, function () {
                    window.location.reload();
                });
             }
        },

        error: function (data) {
            var title = "An error occurred";
            var message = data;
            swal(title, message, "error");
        }
    });
}

function search(url,query){

    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            query: query,
        },

        success: function (data) {
              status = data['status']

              if(status=='true'){
                 var title = "Rated Successfully";
                var message = "Ratings Submitted Successfully";
                swal(title, message, "success");
             }
        },

        error: function (data) {
            var title = "An error occurred";
            var message = data;
            swal(title, message, "error");
        }
    });
}

function getProductDetails(url,order_item_pk){

    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            order_item_pk: order_item_pk,
        },

        success: function (data) {
              status = data['status']

              if(status=='true'){
                   $('.product_name').text(data['product_name']);
                    $('.product_category').text(data['product_category']);
                   $('.product-mrp').text(data['product_mrp']);
                   $('.product-image').attr("src", data['product_image']);
                   $('.return-product-button').attr("data-pk",data['order_item_pk'] );

                  $('#CancelOrder').css({
                    'display':'block',
                });
             }
        },

        error: function (data) {
            var title = "An error occurred";
            var message = data;
            swal(title, message, "error");
        }
    });
}

function returnProduct(url,order_item_pk){

    cancel_reason = $('#cancelreason').find(":checked").val();
    cancel_review = $('#cancel-review').val();


    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            order_item_pk: order_item_pk,
            cancel_reason:cancel_reason,
            cancel_review:cancel_review,
        },

        success: function (data) {
              status = data['status']

              if(status=='accepted'){
                    var title = "Return Submitted";
                    var message = "Product return successfully submitted";
                    swal(title, message, "success");
             } else {
                var title = "Period is over";
                var message = "Return time period is over";
                swal(title, message, "error");
             }
        },

        error: function (data) {
            var title = "An error occurred";
            var message = data;
            swal(title, message, "error");
        }
    });
}

function cancelOrder(url, order_pk) {
    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            order_pk: order_pk,
        },
        success: function (data) {
            status = data['status'];

            if (status === "cancelled") {
                var title = "Order Cancelled";
                var message = "Successfully cancelled";
                swal(title, message, "success");
                window.location.reload();
            } else if (status === "not_eligible") {
                var title = "Not Eligible for Cancellation";
                var message = "Order Cancellation period is over";
                swal(title, message, "error");
            } else if (status == "failed"){
                var title = "failed";
                var message = "Already Cancelled";
                swal(title, message, "error");
            }
            else {
                var title = "An error occurred";
                var message = "Unexpected response from the server";
                swal(title, message, "error");
            }
        },
        error: function (data) {
            var title = "An error occurred";
            var message = data;
            swal(title, message, "error");
        }
    });
}
function cancelOrderItem(url, order_pk) {
    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        data: {
            order_pk: order_pk,
        },
        success: function (data) {
            status = data['status'];

            if (status === "cancelled") {
                var title = "Order Item Cancelled";
                var message = "Successfully Cancelled";
                swal(title, message, "success");
                $(`.Delivery-Status-${order_pk}`).html('<p style="color: #9f0525;">Item Cancelled</p>')
            } 
            else if (status === "order_cancelled") {
                var title = "Order has been cancelled";
                var message = "Order Cancelled";
                swal(title, message, "success");
                window.location.reload();
            }
            else if (status === "not_eligible") {
                var title = "Not Eligible for Cancellation";
                var message = "Order Cancellation period is over";
                swal(title, message, "error");
            } else if (status == "failed"){
                var title = "failed";
                var message = "Already Cancelled";
                swal(title, message, "error");
            }
            else {
                var title = "An error occurred";
                var message = "Unexpected response from the server";
                swal(title, message, "error");
            }
        },
        error: function (data) {
            var title = "An error occurred";
            var message = data;
            swal(title, message, "error");
        }
    });
}

  
  function validateOrder($selector) {
    var parent = $selector.parents('#checkOutproduct');
    var url = parent.find('#validate').attr('data-url');
    var delivery_type = $('[name="delivery_type"]').val();
    let is_express = $("#express").is(":checked")
    delivery_type = is_express?"express":"normal";
  
    $.ajax({
      url: url,
      type: "GET",
      dataType: "json",
      data : {
        delivery_type: delivery_type,
      },
      success: function(data) {
        var status = data["status"]
        var redirect = data["redirect"]
        var redirect_url = data["redirect_url"]
        if (status === "true") {
            if (DeliveryDateChecker()){
                $('.tab3').removeClass('active')
                $('.tab2').addClass('active')

                $("#payment #checkOutproduct").hide();
                $("#payment .tab-click").slideDown("slow", function () {});
                $("#payment .tab-click").show();
            }
        } else {
            // window.location.href =  redirect_url;
            let title = data["title"]
            let message = data["message"]
            swal(title, message, "error")
            document.onkeydown = function (evt) {
                    window.location.reload()
                };
            document.onmousedown = function (evt) {
                window.location.reload()
            };
        }
      },
      error: function(xhr, status, error) {
        // Handle errors
        console.error("Error occurred during product validation:", error);
      }
    });
  }