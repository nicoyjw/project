function worldClock(zone, region) {
    var dst = 0;
    var time = new Date();
    var gmtMs = time.getTime() + (time.getTimezoneOffset() * 60000);
    var gmtTime = new Date(gmtMs);
    var day = gmtTime.getDate();
    var month = gmtTime.getMonth();
    var year = gmtTime.getYear();
    if (year < 1000) {
        year += 1900;
    }
    var monthArray = new Array("January", "February", "March", "April", "May", "June", "July", "August",
        "September", "October", "November", "December");
    var monthDays = new Array("31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31");
    if (year % 4 == 0) {
        monthDays = new Array("31", "29", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31");
    }
    if (year % 100 == 0 && year % 400 != 0) {
        monthDays = new Array("31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31");
    }
    var hr = gmtTime.getHours() + zone;
    var min = gmtTime.getMinutes();
    var sec = gmtTime.getSeconds();
    if (hr >= 24) {
        hr = hr - 24;
        day -= -1;
    }
    if (hr < 0) {
        hr -= -24;
        day -= 1;
    }
    if (hr < 10) {
        hr = " " + hr;
    }
    if (min < 10) {
        min = "0" + min;
    }
    if (sec < 10) {
        sec = "0" + sec;
    }
    if (day <= 0) {
        if (month == 0) {
            month = 11;
            year -= 1;
        } else {
            month = month - 1;
        }
        day = monthDays[month];
    }
    if (day > monthDays[month]) {
        day = 1;
        if (month == 11) {
            month = 0;
            year -= -1;
        } else {
            month -= -1;
        }
    }
    var startDst;
    var endDst;
    var dayDst;
    var currentTime;
    if (region == "NAmerica") {
        startDst = new Date();
        endDst = new Date();
        startDst.setMonth(3);
        startDst.setHours(2);
        startDst.setDate(1);
        dayDst = startDst.getDay();
        if (dayDst != 0) {
            startDst.setDate(8 - dayDst);
        } else {
            startDst.setDate(1);
        }
        endDst.setMonth(9);
        endDst.setHours(1);
        endDst.setDate(31);
        dayDst = endDst.getDay();
        endDst.setDate(31 - dayDst);
        currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDst && currentTime < endDst) {
            dst = 1;
        }
    }
    if (region == "Europe") {
        startDst = new Date();
        endDst = new Date();
        startDst.setMonth(2);
        startDst.setHours(1);
        startDst.setDate(31);
        dayDst = startDst.getDay();
        startDst.setDate(31 - dayDst);
        endDst.setMonth(9);
        endDst.setHours(0);
        endDst.setDate(31);
        dayDst = endDst.getDay();
        endDst.setDate(31 - dayDst);
        currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDst && currentTime < endDst) {
            dst = 1;
        }
    }

    if (region == "SAmerica") {
        startDst = new Date();
        endDst = new Date();
        startDst.setMonth(9);
        startDst.setHours(0);
        startDst.setDate(1);
        dayDst = startDst.getDay();
        if (dayDst != 0) {
            startDst.setDate(22 - dayDst);
        } else {
            startDst.setDate(15);
        }
        endDst.setMonth(1);
        endDst.setHours(11);
        endDst.setDate(1);
        dayDst = endDst.getDay();
        if (dayDst != 0) {
            endDst.setDate(21 - dayDst);
        } else {
            endDst.setDate(14);
        }
        currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDst || currentTime < endDst) {
            dst = 1;
        }
    }
    if (region == "Cairo") {
        startDst = new Date();
        endDst = new Date();
        startDst.setMonth(3);
        startDst.setHours(0);
        startDst.setDate(30);
        dayDst = startDst.getDay();
        if (dayDst < 5) {
            startDst.setDate(28 - dayDst);
        } else {
            startDst.setDate(35 - dayDst);
        }
        endDst.setMonth(8);
        endDst.setHours(11);
        endDst.setDate(30);
        dayDst = endDst.getDay();
        if (dayDst < 4) {
            endDst.setDate(27 - dayDst);
        } else {
            endDst.setDate(34 - dayDst);
        }
        currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDst && currentTime < endDst) {
            dst = 1;
        }
    }
    if (region == "Israel") {
        startDst = new Date();
        endDst = new Date();
        startDst.setMonth(3);
        startDst.setHours(2);
        startDst.setDate(1);
        endDst.setMonth(8);
        endDst.setHours(2);
        endDst.setDate(25);
        dayDst = endDst.getDay();
        if (dayDst != 0) {
            endDst.setDate(32 - dayDst);
        } else {
            endDst.setDate(1);
            endDst.setMonth(9);
        }
        currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDst && currentTime < endDst) {
            dst = 1;
        }
    }
    if (region == "Beirut") {
        startDst = new Date();
        endDst = new Date();
        startDst.setMonth(2);
        startDst.setHours(0);
        startDst.setDate(31);
        dayDst = startDst.getDay();
        startDst.setDate(31 - dayDst);
        endDst.setMonth(9);
        endDst.setHours(11);
        endDst.setDate(31);
        dayDst = endDst.getDay();
        endDst.setDate(30 - dayDst);
        currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDst && currentTime < endDst) {
            dst = 1;
        }
    }
    if (region == "Baghdad") {
        startDst = new Date();
        endDst = new Date();
        startDst.setMonth(3);
        startDst.setHours(3);
        startDst.setDate(1);
        endDst.setMonth(9);
        endDst.setHours(3);
        endDst.setDate(1);
        dayDst = endDst.getDay();
        currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDst && currentTime < endDst) {
            dst = 1;
        }
    }
    if (region == "Australia") {
        startDst = new Date();
        endDst = new Date();
        startDst.setMonth(9);
        startDst.setHours(2);
        startDst.setDate(31);
        dayDst = startDst.getDay();
        startDst.setDate(31 - dayDst);
        endDst.setMonth(2);
        endDst.setHours(2);
        endDst.setDate(31);
        dayDst = endDst.getDay();
        endDst.setDate(31 - dayDst);
        currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDst || currentTime < endDst) {
            dst = 1;
        }
    }
    if (dst == 1) {
        hr -= -1;
        if (hr >= 24) {
            hr = hr - 24;
            day -= -1;
        }
        if (hr < 10) {
            hr = " " + hr;
        }
        if (day > monthDays[month]) {
            day = 1;
            if (month == 11) {
                month = 0;
                year -= -1;
            } else {
                month -= -1;
            }
        }
        return hr + ":" + min;
        //return monthArray[month] + " " + day + ", " + year + "<br>" + hr + ":" + min + ":" + sec + " DST";
    } else {
        return hr + ":" + min;
        //return monthArray[month] + " " + day + ", " + year + "<br>" + hr + ":" + min + ":" + sec;
    }
}

function worldClockZone() {
    document.getElementById("Clock1").innerHTML = worldClock(8, "Beijing");  //中国 / Beijing 北京
    document.getElementById("Clock2").innerHTML = worldClock(0, "NAmerica"); //爱尔兰
    document.getElementById("Clock3").innerHTML = worldClock(-5, "NAmerica");  //美国 / New York 纽约
    document.getElementById("Clock4").innerHTML = worldClock(10, "Australia"); //澳大利亚 / Sydney 悉尼
    document.getElementById("Clock7").innerHTML = worldClock(0, "Seoul"); //英国伦敦
    document.getElementById("Clock8").innerHTML = worldClock(1, "Europe"); //德国 / Bolin 柏林
    setTimeout("worldClockZone()", 1000);
}

