function setupExpertPage() {
  $('.js-become-expert-overall-chart').highcharts(Highcharts.merge({

    chart: {
      type: 'gauge'
    },

    title: null,

    pane: {
      center: ['50%', '85%'],
      size: '140%',
      startAngle: -90,
      endAngle: 90,

      background: {
        backgroundColor: '#EEE',
        innerRadius: '60%',
        outerRadius: '100%',
        shape: 'arc'
      }

    },

    plotOptions: {
      solidgauge: {
        dataLabels: {
          y: 5,
          borderWidth: 0,
          useHTML: true
        }
      }
    },

    tooltip: {
      enabled: false
    },

    yAxis: {
      lineWidth: 0,
      minorTickInterval: null,
      tickPixelInterval: 400,
      tickWidth: 0,
      title: {
        y: -70
      },
      labels: {
        y: 16
      },
      min: 0,
      max: 10,
      title: {
        text: 'Sustainability'
      },
    	plotBands: [{
        borderWidth: 2,
        borderColor: 'white',
        from: 0,
        to: 3.3,
        color: '#5AD7F9',
        innerRadius: '60%',
        outerRadius: '100%',
        label: {
        	text: 'Poor',
          rotation: -60,
          x: 60,
          y: 50,
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
        innerRadius: '60%',
        outerRadius: '100%',
        label: {
        	text: 'Normal',
          x: 118,
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
        innerRadius: '60%',
        outerRadius: '100%',
        label: {
        	text: 'Good',
          rotation: 60,
          x: 215,
          y: 32,
          style: {
            fontSize: '18px',
            color: 'white'
          }
        }
      }]
    },

    credits: {
      enabled: false
    },

    series: [{
      name: 'Sustainability',
      data: [gon.expert_overall_score],
      dataLabels: {
    		borderWidth: 0,
        y: 45,
        useHTML: true,
        format: '<div style="text-align:center;"><span style="font-size:25px;color:black;">{y:.1f}</span><svg fill="#000000" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7.41 15.41L12 10.83l4.59 4.58L18 14l-6-6-6 6z"/><path d="M0 0h24v24H0z" fill="none"/></svg></div>'
      },
      pivot: {
      	backgroundColor: 'white'
      },
      dial: {
      	baseWidth: 20,
        backgroundColor: 'rgba(0, 0, 0, 0.7)',
        baseLength: 0,
        radius: '70%',
        rearLength: '10%'
      }
    }]
  }));
}
