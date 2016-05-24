function setupExpertPage() {
  overall_meter_gauge = {

    title: {
      text: 'Overall',
      y: 15
    },

    pane: {
      size: '200'
    },

    yAxis: {
      plotBands: [
        {
          borderWidth: 2,
          borderColor: 'white',
          from: 0,
          to: 3.3,
          color: '#5AD7F9',
          innerRadius: '40%',
          outerRadius: '100%',
          label: {
            text: 'Poor',
            rotation: -60,
            x: 60,
            y: 55,
            style: {
              fontSize: '18px',
              color: 'white'
            }
          }
        },{
        	borderWidth: 2,
          borderColor: 'white',
          from: 3.3,
          to: 6.6,
          color: '#2DB9EA',
          innerRadius: '40%',
          outerRadius: '100%',
          label: {
          	text: 'Normal',
            x: 98,
            y: 30,
            style: {
              fontSize: '18px',
              color: 'white'
            }
          }
        },{
        	borderWidth: 2,
          borderColor: 'white',
          from: 6.6,
          to: 10,
          color: '#1599D6',
          innerRadius: '40%',
          outerRadius: '100%',
          label: {
          	text: 'Good',
            rotation: 60,
            x: 170,
            y: 45,
            style: {
              fontSize: '18px',
              color: 'white'
            }
          }
        }
      ]
    },

    series: [{
      name: 'Overall',
      data: [gon.charts.performance.score],
      dataLabels: {
        borderWidth: 0,
        y: 70,
        useHTML: true,
        format: '<div style="text-align:center;"><span style="font-size:35px;color:black;">{y:.2f}</span>' + gon.charts.overall.icon + '</div>'
      }
    }]

  };

  performance_meter_gauge = {

    title: {
      text: 'Performance',
      y: 15
    },

    pane: {
      size: '100'
    },

    yAxis: {
      plotBands: [
        {
          borderWidth: 2,
          borderColor: 'white',
          from: 0,
          to: 3.3,
          color: '#5AD7F9',
          innerRadius: '40%',
          outerRadius: '100%'
        },{
        	borderWidth: 2,
          borderColor: 'white',
          from: 3.3,
          to: 6.6,
          color: '#2DB9EA',
          innerRadius: '40%',
          outerRadius: '100%'
        },{
        	borderWidth: 2,
          borderColor: 'white',
          from: 6.6,
          to: 10,
          color: '#1599D6',
          innerRadius: '40%',
          outerRadius: '100%'
        }
      ]
    },

    series: [{
      name: 'Performance',
      data: [gon.charts.performance.score],
      dataLabels: {
        borderWidth: 0,
        y: 45,
        useHTML: true,
        format: '<div style="text-align:center;"><span style="font-size:20px;color:black;">{y:.2f}</span>' +  gon.charts.performance.icon + '</div>'
      }
    }]

  };

  $('.js-become-expert-overall-chart').highcharts(Highcharts.merge(highchartsMeterGauge(), overall_meter_gauge));

  $('.js-become-performance-overall-chart').highcharts(Highcharts.merge(highchartsMeterGauge(), performance_meter_gauge));

}
