// function countDown (startTimestamps, validTime = 7200) {
//     let nowTimestamps = Date.parse(new Date()) / 1000;
//     let endTimestamps = parseInt(startTimestamps) + parseInt(validTime);
//     let interval = endTimestamps - nowTimestamps;
//     let h, m, s;
//     if (interval < 0) return "(00:00:00)";
//     h=Math.floor(interval / 60 / 60 % 24);
//     m=Math.floor(interval / 60 % 60);
//     s=Math.floor(interval % 60);
//     return `(${h}:${m}:${s})`;
// }
//
// function showCountDown(validTime){
//     let element, status, startTime, timeStr, countText;
//     element = document.getElementById('count_down');
//     status = element.getAttribute('data-status');
//     if(status != 'unpaid') return;
//     countText = document.getElementById('count-text');
//     if(countText != null){
//         element.removeChild(countText);
//     }
//     startTime = element.getAttribute('data-timestamp');
//     timeStr = countDown(startTime, validTime);
//     let spanNode = document.createElement('span');
//     let textNode = document.createTextNode(timeStr);
//     spanNode.appendChild(textNode);
//     element.appendChild(spanNode);
//     spanNode.setAttribute('id', 'count-text');
//     setInterval(showCountDown, 1000, validTime);
// }