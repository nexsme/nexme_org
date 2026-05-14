
$(document).on('submit', 'form.web-ajax', function (e) {
    e.preventDefault();
    var $this = $(this);
    var valid = true;

    if (valid) {
        document.onkeydown = function (evt) {
            return false;
        };

        var url = $this.attr('action');
        var method = $this.attr('method');
        var isReload = $this.hasClass('reload');
        var isCloseModal = $this.hasClass('close-modal');
        var isRedirect = $this.hasClass('redirect');
        var noLoader = $this.hasClass('no-loader');
        var noPopup = $this.hasClass('no-popup');
        var isRunFunctionAfter = $this.hasClass('run-function-after');
        var function_name = $this.attr('data-function');
        var selector_class = $this.attr('data-after-function-selector-parent-class');
        var $after_selector = '';
        if (selector_class) {
            $after_selector = $('.' + selector_class);
        }

        var data = $this.serialize();

        // if (!noLoader) {
        //     show_loader();
        // }

        jQuery.ajax({
            type: method,
            url: url,
            dataType: 'json',
            data: new FormData(this),
            contentType: false,
            cache: false,
            processData: false,

            success: function (data) {
                // if (!noLoader) {
                //     remove_popup();
                // }

                var message = data['message'];
                var status = data['status'];
                var title = data['title'];
                var redirect = data['redirect'];
                var redirect_url = data['redirect_url'];
                var new_redirect_window = data['new_redirect_window'];
                var new_window_url = data['new_window_url']
                var stable = data['stable'];
                var pk = data['pk'];

                auto_redirect = $("#auto_redirect").val();
                if (status == 'true') {
                    if (title) {
                        title = title;
                    } else {
                        title = "Success";
                    }

                    function doAfter() {
                        if (isRunFunctionAfter) {
                            doAfterAction(function_name, data, $this, $after_selector);
                        }

                        if (stable != "true") {
                            if (auto_redirect != "no") {
                                if (isRedirect && redirect == 'true') {
                                    window.location.href = redirect_url;
                                }
                                if (isReload) {
                                    window.location.reload();
                                }
                            }
                        }
                    }

                    if (new_redirect_window == 'true') {
                        if (new_window_url != "" || new_window_url != null || new_window_url != undefined) {
                            window.open(new_window_url);
                        }
                    }

                    if (isCloseModal){
                        $('[data-dismiss="modal"]').trigger('click');
                    }

                    if (noPopup) {
                        doAfter();
                    } else {
                        swal({
                            title: title,
                            text: message,
                            type: "success"
                        }, function () {

                            doAfter();
                        });
                    }
                    document.onkeydown = function (evt) {
                        return true;
                    };

                } else {
                    if (title) {
                        title = title;
                    } else {
                        title = "An Error Occurred";
                    }

                    swal(title, message, "error");

                    if (stable != "true") {
                        window.setTimeout(function () {
                        }, 2000);
                    }
                    document.onkeydown = function (evt) {
                        return true;
                    };

                    $this.find('button, input[type="submit"]').removeAttr('disabled');

                }

            },
            error: function (data) {
                remove_popup();

                $this.find('button, input[type="submit"]').removeAttr('disabled');
                var title = "An error occurred";
                var message = "An error occurred. Please try again later.";
                document.onkeydown = function (evt) {
                    return true;
                };
                swal(title, message, "error");
            }
        });
    }
});
