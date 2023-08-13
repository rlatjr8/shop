<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>출석체크</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            text-align: center;
            padding: 5px;
            border: 1px solid #ccc;
        }

        th {
            background-color: #f2f2f2;
        }

        td.today {
            background-color: lightgreen;
        }

        td.checked {
            background-color: lightblue;
        }
    </style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script>
    $(document).ready(function () {

    	function populateCalendar(daysInMonth, firstDayOfWeek, today, attendanceData) {
    	    const calendar = $("#attendance-calendar");
    	    const yearMonth = $("#calendar-year-month");
    	    const monthNames = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
    	    const dayNames = ["일", "월", "화", "수", "목", "금", "토"];
    	    let table = '<tr>';

    	    yearMonth.text(today.getFullYear() + "년 " + monthNames[today.getMonth()]);

    	    for (let i = 0; i < 7; i++) {
    	        table += '<th scope="col">' + dayNames[i] + '</th>';
    	    }
    	    table += '</tr>';

    	    let cell = 1;
    	    let day = 1;

    	    while (day <= daysInMonth) {
    	        table += '<tr>';
    	        for (let i = 0; i < 7; i++) {
    	            if (cell >= firstDayOfWeek + 1 && day <= daysInMonth) {
    	                let className = "";

    	                // Check if the current day is in the attendanceData
    	                const dayInAttendanceData = attendanceData.includes(day.toString());

    	                if (day === today.getDate() && !dayInAttendanceData) {
    	                    className = "today";
    	                } else if (dayInAttendanceData) {
    	                    className = "checked";
    	                }
    	                table += '<td class="' + className + '">' + day + '</td>';
    	                day++;
    	            } else {
    	                table += '<td></td>';
    	            }
    	            cell++;
    	        }
    	        table += '</tr>';
    	    }

    	    calendar.html(table);
    	}

        function createCalendar() {
            const date = new Date();
            const year = date.getFullYear();
            const month = date.getMonth();
            const daysInMonth = new Date(year, month + 1, 0).getDate();
            const firstDayOfWeek = new Date(year, month, 1).getDay();

            $.ajax({
                url: "/member/attendanceData",
                method: "GET",
                success: function (attendanceDataList) {
                    // 새롭게 추가된 코드
                    const checkedInDates = attendanceDataList
                        .filter(data => data.attended)
                        .map(data => data.date);

                    populateCalendar(daysInMonth, firstDayOfWeek, date, checkedInDates); // 인자로 checkedInDates를 사용하도록 변경
                },
                error: function () {
                    alert("출석체크 데이터를 불러오는 데 실패했습니다.");
                }
            });
        }

        $("#attendance-btn").click(function () {
            // 출석체크 버튼 클릭 시 서버에 출석체크 요청
            $.ajax({
                url: "/member/attendance", // 경로가 올바른지 확인해주세요.
                method: "POST",
                success: function (response) {
                    alert(response.message);
                    if (response.status === "OK") {
                        createCalendar();
                        const todayCell = $("td.today");
                        todayCell.removeClass("today");
                        todayCell.addClass("checked");
                    }
                },
                error: function (xhr, status, error) {
                    if (xhr.status === 409) { // 충돌 오류(이미 출석체크를 했음을 의미)
                        alert(xhr.responseText);
                    } else {
                        alert("출석체크에 실패했습니다. 에러: " + error);
                    }
                }
            });
        });

        createCalendar(); // $(document).ready() 내부에서 호출해야 합니다.
    });
</script>
</head>
<body>
<h1>출석체크</h1>
<button id="attendance-btn">출석체크하기</button>

<h3>출석체크 </h3>
<span id="calendar-year-month"></span>
<table id="attendance-calendar"></table>

</body>
</html>