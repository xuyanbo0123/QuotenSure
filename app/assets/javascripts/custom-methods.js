$.validator.addMethod('birthday', function(value, element)
{
    try
    {
        var vDate = $.datepicker.parseDate('mm/dd/yy', value);
        var minDate = new Date();
        minDate.setFullYear(minDate.getFullYear() - 80);
        minDate.setDate(minDate.getDate() - 1);
        var maxDate = new Date();
        maxDate.setFullYear(maxDate.getFullYear() - 16);
        if (vDate<maxDate && vDate > minDate)
            return true;
    }
    catch (e)
    {
    }
    return false;
});

$.validator.addMethod('expiration-date', function(value, element)
{
    try
    {
        var vDate = $.datepicker.parseDate('mm/dd/yy', value);
        var minDate = new Date();
        minDate.setDate(minDate.getDate() - 1);
        var maxDate = new Date();
        maxDate.setFullYear(maxDate.getFullYear() + 10);
        if (vDate<maxDate && vDate > minDate)
            return true;
    }
    catch (e)
    {
    }
    return false;
});
