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
          enabled: false,
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
      user_response(id, index, question)
      index += 1;
    }
  });
  var user_response = function(id, index, question) {
    $.post('/surveys/responses', { id: id }, function(user_response) {
      if (user_response) {
      $("#" + index).append("<span class = 'user_response'><h4>You answered: "+user_response[question]+" </h4>")
      } else {
        return null
      };
    })
  };
});


