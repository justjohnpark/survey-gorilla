$(document).ready(function() {

  var id = parseInt($('#survey-id').html())
  $.post('/surveys/results', { id: id }, function(response) {
    var index = 0;
    for (var question in response) {

      $('#container').append("<div class='stats' id="+ index +"></div>")

      var labels = [];
      var data = []
      for (var choice in response[question]) {
        data.push(response[question][choice])
        labels.push(choice)
        }

      $("#" + index).highcharts({
        chart: {
          type: 'column',
          backgroundColor: '#F0F5FF',
          plotBorderWidth: 1
        },
        title: {
          text: question
        },
          xAxis: {
          categories: labels,
        },
        yAxis: {
          allowDecimals: false,
          min: 0,
          title: {
            text: 'Votes'
          }
        },
        tooltip: {
          headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
          pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
              '<td style="padding:0"><b>{point.y} vote(s)</b></td></tr>',
          footerFormat: '</table>',
          shared: true,
          useHTML: true
        },
        plotOptions: {
          column: {
            pointPadding: 0.2,
            borderWidth: 0
          }
        },
        series: [{data: data,
          showInLegend: false}]
      });
       // $("#" + index + " .highcharts-container").prepend("<input class='form-control'>")
      index += 1;
    }
  });
});


