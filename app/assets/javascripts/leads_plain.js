$(document).ready(function () {
    //prevent enter to submit
    $(window).keydown(function (event) {
        if (event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });

    /*Adding Placeholder Support in Older Browsers*/
    $('input, textarea').placeholder();

    /*Tooltips*/
    $('.tooltipped').tooltip();

    /*Custom Style Checkboxes and Radios*/
    $('input').iCheck({
        checkboxClass: 'icheckbox',
        radioClass: 'iradio'
    });

////////////////////////////*APPLICATION WIZARD*/////////////////////////

    /*Application Wizard Form Validation*/
    var newLead = $('#new_lead');
    var leadData = $('#lead_data');
    newLead.validate({
        errorPlacement: function(error, element) {},
        ignore: '.ignore'
    });

    /*Cashing variables*/
    var prevTab = $('.prev-tab');
    var nextTab = $('.next-tab');
    var addVehicle = $('a.add_fields.vehicle');
    var addDriver = $('a.add_fields.driver');
    var addIncident = $('a.add_fields.incident');
    var select_has_incident = $('.has_incident');

    var submitWiz = $('.submit-lead');
    var tabLink = $('.tab-links > .tab-link');
    var tcpa = $('#tcpa_disclosure');

    var oneVehicle = $('#vehicles').find('.nested-fields');
    var oneDriver = $('#drivers').find('.nested-fields');
    var policy = $('#policy').find('.nested-fields');
    var contact = $('#contact').find('.nested-fields');
    var incidents = $('#incidents');

    oneDriver.find('input, select').addClass('ignore');
    policy.find('input, select').addClass('ignore');
    contact.find('input, select').addClass('ignore');
    incidents.find('input, select').addClass('ignore');

    /*Tabs*/
    tabLink.on('click', function (e) {
        tabLink.removeClass('active');
        $(this).addClass('active');
        if ($(this).index() == 0) {
            prevTab.addClass('hidden');
        } else {
            prevTab.removeClass('hidden');
        }
    });
    nextTab.on('click', function (e) {
        moveTab('Next');
        showButtons();
        e.preventDefault();
    });
    prevTab.on('click', function (e) {
        moveTab('Previous');
        showButtons();
        e.preventDefault();
    });

    function showButtons() {
        var currentTab = '';
        tabLink.each(function () {
            if ($(this).hasClass('active')) {
                currentTab = $(this);
                return false;
            }
        });
        addVehicle.removeClass('hidden');
        addDriver.removeClass('hidden');
        addIncident.removeClass('hidden');
        prevTab.removeClass('hidden');
        nextTab.removeClass('hidden');
        submitWiz.removeClass('hidden');
        tcpa.removeClass('hidden');
        newLead.find('input, select').addClass('ignore');

        if (currentTab.hasClass('vehicle'))
        {
            $('#vehicle').find('input, select').removeClass('ignore');
            prevTab.addClass('hidden');
        }
        else
        {
            addVehicle.addClass('hidden');
            $('#vehicle').find('.error').removeClass('error');
        }

        if (currentTab.hasClass('driver'))
            $('#driver').find('input, select').removeClass('ignore');
        else
        {
            addDriver.addClass('hidden');
            $('#driver').find('.error').removeClass('error');
        }

        if (currentTab.hasClass('policy'))
        {
            $('#policy').find('input, select').removeClass('ignore');
            refreshPolicy();
        }
        else
            $('#policy').find('.error').removeClass('error');

        if (currentTab.hasClass('contact'))
            $('#contact').find('input, select').removeClass('ignore');
        else
            $('#contact').find('.error').removeClass('error');

        if (currentTab.hasClass('incident'))
        {
            $('#incident').find('input, select').removeClass('ignore');
            nextTab.addClass('hidden');
            refreshHasIncident();
            incidents.find('.nested-fields').each(function () {
                    refreshIncident($(this));
                }
            )
        } else {
            addIncident.addClass('hidden');
            submitWiz.addClass('hidden');
            tcpa.addClass('hidden');
            $('#incident').find('.error').removeClass('error');
        }
    }

    function moveTab(nextOrPrev) {
        var currentTab = '';
        tabLink.each(function () {
            if ($(this).hasClass('active')) {
                currentTab = $(this);
                return false;
            }
        });

        //indicateErrorSelectBox();

        if (nextOrPrev == 'Next' && newLead.valid() == true) {
            if (currentTab.next().length) {
                currentTab.removeClass('active');
                currentTab.next().addClass('active').find('a').trigger('click');
            }
        } else if (nextOrPrev == 'Previous') {
            if (currentTab.prev().length) {
                currentTab.removeClass('active');
                currentTab.prev().addClass('active').find('a').trigger('click');
            }
        } else {
            return false;
        }
    }

    //cocoon
    initializeCocoon('vehicle');
    initializeCocoon('driver');
    initializeCocoon('incident');

    submitWiz.on('click', function (e) {
        finalize();
    });


    initializeVehicle(oneVehicle);
    initializeDriver(oneDriver, true);
    initializePolicy();
    initializeContact();
    initializeHasIncident();



    $('#lead_contact_attributes_zip').rules('add', {
        required: true,
        zipcodeUS: true,
        remote: function () {
            return '/validate_zip/' + $('#lead_contact_attributes_zip').val() + '.json';
        }
    });


    function initializeCocoon(name) {
        var obj_selector = '#' + name + 's';

        $('a.add_fields.' + name).
            prepend("<i class='fa fa-plus'></i>").
            data('association-insertion-position', 'append').
            data('association-insertion-node', obj_selector);

        $(obj_selector).on('cocoon:before-insert', function (e, obj_to_be_added) {
            if (newLead.valid()) {
                $(this).find('.ctrl').fadeOut(100, 'swing');
                $(this).find('.toggle-btn.plus').show();
                $(this).find('.toggle-btn.minus').hide();
                obj_to_be_added.fadeIn('slow');
            } else {
                //indicateErrorSelectBox();
            }

        }).on('cocoon:after-insert', function (e, added_obj) {
            added_obj.find('a.remove-btn').show();
            added_obj.find('a.fake.remove-btn').hide();
            if (name == 'driver') initializeDriver(added_obj, false);
            if (name == 'vehicle') initializeVehicle(added_obj);
            if (name == 'incident') initializeIncident(added_obj);
            LeadiD.formcapture.init();
        }).on('cocoon:before-remove', function (e, obj) {
            $(this).data('remove-timeout', 1000);
            obj.fadeOut('fast');
        });
    }

    function initializeHidden(tab) {
        var rid = tab.find('input.rid');
        var rid_value = /lead\[\w+_attributes\]\[(\d+)\]\[rid\]/.exec(rid.attr('name'))[1];
        rid.val(rid_value);
    }
    function initializeBtnBar(tab) {
        tab.find('a.toggle-btn')
            .on('click', function () {
                var obj = $(this).closest('.nested-fields');
                if (obj.find('input, select').valid())
                {
                    obj.find('.ctrl').fadeToggle(100, 'swing');
                    $(this).closest('.btn-bar').children('.toggle-btn').toggle();
                }
                else
                {
                    //indicateErrorSelectBox();
                }
            });
    }

    // Bind event handlers for inputs on vehicle tab
    //-------------------------------------------------------------------------
    function initializeVehicle(vehicle) {
        var select_year = vehicle.find('select.year');
        var numOfOptions = 2016-1980;
        select_year.html("<option value = ''>--</option>");
        for (var i = numOfOptions; i >=1 ; --i) {
            var year = i+1980;
            select_year.append("<option value = '" + i + "'>" + year + "</option>");
        }
        select_year.closest('.form-group.init-fade').fadeIn();
        initializeHidden(vehicle);
        initializeBtnBar(vehicle);
        refreshVehicle(vehicle);

        var select_make = vehicle.find('select.make');
        var select_model = vehicle.find('select.model');
        var select_vehicle_use = vehicle.find('select.vehicle-use');
        showCommuteDay(select_vehicle_use);
        select_year
            .on('change', function (ev, obj) {
                refreshVehicle(vehicle);
                var api_url = '../years/' + $(this).val() + '/makes.json';
                $.ajax({
                    url: api_url,
                    dataType: 'json',
                    success: function (json) {
                        showNextSelect(select_make, json);
                    }
                });
            });

        select_make
            .on('change', function () {
                refreshVehicle(vehicle);
                var year_id = vehicle.find('select').filter('.year').val();
                var api_url = '../years/' + year_id + '/makes/' + $(this).val() + '/models.json';
                $.ajax({
                    url: api_url,
                    dataType: 'json',
                    success: function (json) {
                        showNextSelect(select_model, json);
                    }
                });
            });

        select_model
            .on('change', function () {
                refreshVehicle(vehicle);
                vehicle.find('.details').fadeIn();
            });

        select_vehicle_use
            .on('change', function () {
                showCommuteDay(select_vehicle_use)
            });
    }
    function showNextSelect(next_obj, json) {
        if (json.length == 0)
            return;
        var numOfOptions = json.length;
        next_obj.html("<option value = ''>--</option>");
        for (var i = 0; i < numOfOptions; i++) {
            next_obj.append("<option value = '" + json[i].id + "'>" + json[i].name + "</option>");
        }
        next_obj.closest('.form-group.init-fade').fadeIn();
    }
    function refreshVehicle(vehicle) {
        refreshTitleForSelect('year', vehicle);
        refreshTitleForSelect('make', vehicle);
        refreshTitleForSelect('model', vehicle);
        showCommuteDay(vehicle.find('select.vehicle-use'));
    }
    function showCommuteDay(vehicle_use) {
        var vehicle = vehicle_use.closest('.nested-fields');
        var use_id = vehicle_use.val();
        var use_text = vehicle_use.children('option[value="' + use_id + '"]').text();
        if (use_text.toUpperCase() == 'COMMUTE') {
            vehicle.find('.form-group.commute-day').fadeIn();
        }
        else {
            vehicle.find('.form-group.commute-day').fadeOut();
        }
    }

    // Bind event handlers for inputs on driver tab
    //-------------------------------------------------------------------------
    function initializeDriver(driver, isPrimary) {
        initializeDate(driver);
        initializeHidden(driver);
        initializeBtnBar(driver);
        showRelationship(driver, isPrimary);
        refreshDriver(driver, isPrimary);
        driver.find('input.name, input.birthday, select.relationship')
            .on('change keyup blur', function () {
                refreshDriver(driver, isPrimary);
            });
    }
    function refreshDriver(driver, isPrimary) {
        var first_name = driver.find('input.first-name').val();
        var last_name = driver.find('input.last-name').val();
        var birthday_text = driver.find('input.birthday').val();

        var select_relationship = driver.find('select.relationship');
        var relationship_id = select_relationship.val();
        var relationship_text = '';
        if (isPrimary)
            relationship_text = 'PRIMARY DRIVER (PD)';
        else if (relationship_id != null)
            relationship_text = select_relationship.children('option[value="' + relationship_id + '"]').text().toUpperCase();


        driver.find('a.name-text').text(first_name.toUpperCase() + " " + last_name.toUpperCase());
        driver.find('a.birthday-text').text(birthday_text);
        driver.find('a.relationship-text').text(relationship_text);
    }
    function showRelationship(driver, isPrimary) {
        var select_relationship = driver.find('select.relationship');
        select_relationship.find('option').each(function () {
                var relationship = $(this).text().toUpperCase();
                if (isPrimary) {
                    if (relationship == 'SELF')
                        $(this).prop('selected', true);
                    else
                        $(this).prop('disabled', true);
                }
                else {
                    if (relationship == 'SELF')
                        $(this).prop('disabled', true);
                }
            }
        );
    }
    function initializeDate(tab) {
        //date picker
        var d = tab.find('input.date_picker');
        d.mask("99/99/9999");
        d.on('blur', function() {
            d.valid();
        })
    }
    // Bind event handlers for inputs on policy tab
    //-------------------------------------------------------------------------
    function initializePolicy() {
        initializeDate(policy);
        refreshPolicy();
        policy.find("select.coverage, select.is-insured")
            .on('change', function () {
                refreshPolicy();
            });
    }
    function refreshPolicy() {
        refreshTitleForSelect('coverage', policy);
        refreshTitleForSelect('is-insured', policy);

        var select_is_insured = policy.find('select.is-insured');
        var text = select_is_insured.children('option[value="' + select_is_insured.val() + '"]').text().toUpperCase();
        if (text == 'YES')
        {
            policy.find('select.company-id').removeClass('ignore');
            policy.find('input.expiration-date').removeClass('ignore');
            policy.find('.row.insured').show();
        }
        else
        {
            policy.find('.row.insured').hide();
            policy.find('select.company-id').addClass('ignore');
            policy.find('input.expiration-date').addClass('ignore');
            policy.find('select.company-id').removeClass('error');
            policy.find('input.expiration-date').removeClass('error');
        }
    }
    // Bind event handlers for inputs on contact tab
    //-------------------------------------------------------------------------
    function initializeContact() {
        contact.find('input.zip-code').val(leadData.data('zip'));
        refreshContact();
        contact.find("input.address, input.zip-code")
            .on("keyup blur", function () {
                refreshContact();
            });
    }
    function refreshContact() {
        var street = contact.find('input.street').val();
        var apt = contact.find('input.apt').val();
        var zip_code = contact.find('input.zip-code').val();

        contact.find('a.address-text').text(street.toUpperCase() + ", " + apt.toUpperCase());
        contact.find('a.zip-code-text').text(zip_code.toUpperCase());

        var api_url = '../zip_codes/' + zip_code + '.json';
        $.ajax({
            url: api_url,
            dataType: 'json',
            success: function (json) {
                if (json == null) {
                    contact.find('a.city-text').html('WRONG').css('color', 'red');
                    contact.find('a.state-text').html('ZIPCODE').css('color', 'red');
                }
                else {
                    contact.find('a.city-text').html(json.city).css('color', '');
                    contact.find('a.state-text').html(json.state).css('color', '');
                }
            }
        });
    }

    //Has Incident
    function initializeHasIncident() {
        select_has_incident.on('change', function () {
            refreshHasIncident();
        });
    }
    function refreshHasIncident() {
        var selected_id = select_has_incident.val();
        if (selected_id == 'false') {
            addIncident.addClass('hidden');
            incidents.addClass('hidden');
        }
        else {
            addIncident.removeClass('hidden');
            incidents.removeClass('hidden');

            if (incidents.find('.nested-fields').length == 0) {
                addIncident.trigger('click');
                incidents.find('a.remove-btn').hide();
                incidents.find('a.fake.remove-btn').show();
            }

        }
    }

    //Incident
    //----------------------------------------------
    function initializeIncident(incident) {
        initializeHidden(incident);
        initializeBtnBar(incident);
        refreshIncident(incident);
        incident.find('select.driver-rid, select.incident-type')
            .on('change', function () {
                refreshIncident(incident);
            });
    }
    function refreshIncident(incident) {

        //which driver?
        var select_driver = incident.find('select.driver-rid');
        var selected_id = select_driver.val();
        select_driver.html("<option value = ''>--</option>");
        var isRemoved = true;
        if (selected_id == null || selected_id == '') {
            isRemoved = false;
            selected_id = '0';
        }
        $('#drivers').find('.nested-fields').each(function () {
                var rid = $(this).find('input.rid').val();
                var name = $(this).find('a.name-text').text();
                if (rid == selected_id) {
                    select_driver.append("<option value = '" + rid + "' selected>" + name + "</option>");
                    isRemoved = false;
                }
                else
                    select_driver.append("<option value = '" + rid + "'>" + name + "</option>");

            }
        );
        if (isRemoved)
            incident.find('a.remove_fields').trigger('click');
        //Incident Type
        var incident_type = incident.find('select.incident-type').val();
        var inputArray = [
            incident.find('.form-group.incident-state'),
            incident.find('.form-group.accident-type'),
            incident.find('.form-group.claim-type'),
            incident.find('.form-group.ticket-type'),
            incident.find('.form-group.damage-type'),
            incident.find('.form-group.at-fault'),
            incident.find('.form-group.paid-amount')
        ];

        var duiArray = [true, false, false, false, false, false, false];
        var accidentArray = [false, true, false, false, true, true, true];
        var claimArray = [false, false, true, false, true, true, true];
        var ticketArray = [false, false, false, true, false, false, false];
        var showArray = [false, false, false, false, false, false, false];

        switch (incident_type) {
            case '_dui' :
                showArray = duiArray;
                break;
            case '_accident' :
                showArray = accidentArray;
                break;
            case '_claim' :
                showArray = claimArray;
                break;
            case '_ticket' :
                showArray = ticketArray;
                break;
        }

        showArray.forEach(function (elem, index) {
            if (elem == true)
            {
                inputArray[index].show();
                inputArray[index].find("select, input").addClass('required');
            }
            else
            {
                inputArray[index].hide();
                inputArray[index].find("select, input").removeClass('required');
            }
        });

        //refresh title
        refreshTitleForSelect('driver-rid', incident);
        refreshTitleForSelect('incident-type', incident);

    }

    //Util functions
    //---------------------------------------------
    function refreshTitleForSelect(name, tab) {
        var obj = tab.find('select.' + name);
        var selected_id = obj.val();
        var selected_text = obj.children('option[value="' + selected_id + '"]').text();
        tab.find('a.' + name + '-text').text(selected_text.toUpperCase());
    }

    //finalize
    function finalize() {
        finalizeHasIncident();
    }
    function finalizeHasIncident() {
        var selected_id = select_has_incident.val();
        if (selected_id == 'false') {
            incidents.find('.nested-fields').each(function () {
                    $(this).find('a.remove_fields').trigger('click');
                }
            )
        }
    }
});