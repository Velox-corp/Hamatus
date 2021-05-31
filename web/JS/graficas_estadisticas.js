// Esta es para archivos subidos          Para estadisticas generales


Morris.Bar({
  element: 'barrasxd',
  data: [
    {x: '2011 Q1', y: 0},
    {x: '2011 Q2', y: 1},
    {x: '2011 Q3', y: 2},
    {x: '2011 Q4', y: 3},
    {x: '2012 Q1', y: 4},
    {x: '2012 Q2', y: 5},
    {x: '2012 Q3', y: 6},
    {x: '2012 Q4', y: 7},
    {x: '2013 Q1', y: 8}
  ],
  xkey: 'x',
  ykeys: ['y'],
  labels: ['Y'],
  barColors: function (row, series, type) {
    if (type === 'bar') {
      var red = Math.ceil(255 * row.y / this.ymax);
      return 'rgb(' + red + ',0,0)';
    }
    else {
      return '#000';
    }
  }
});

// Aqui para flujos realizados             Para estadisticas de la empresa B)
Morris.Bar({
  element: 'barras2xd',
  data: [
    {x: '2011 Q1', y: 3, z: 2, a: 3},
    {x: '2011 Q2', y: 2, z: null, a: 1},
    {x: '2011 Q3', y: 0, z: 2, a: 4},
    {x: '2011 Q4', y: 2, z: 4, a: 3}
  ],
  xkey: 'x',
  ykeys: ['y', 'z', 'a'],
  labels: ['Y', 'Z', 'A']
}).on('click', function(i, row){
  console.log(i, row);
});

//archivos subidos                   Para el equipo xd
Morris.Bar({
  element: 'barras3xd',
  data: [
    {x: '2011 Q1', y: 3, z: 2, a: 3},
    {x: '2011 Q2', y: 2, z: null, a: 1},
    {x: '2011 Q3', y: 0, z: 2, a: 4},
    {x: '2011 Q4', y: 2, z: 4, a: 3}
  ],
  xkey: 'x',
  ykeys: ['y', 'z', 'a'],
  labels: ['Y', 'Z', 'A']
}).on('click', function(i, row){
  console.log(i, row);
});

//esta grafica es para flujos hechos               Para estadisticas del equipo xd



//Esta es para usuarios activos                    Para estadisticas del equipo
Morris.Donut({
  element: 'dona2xd',
  data: [
    {value: 70, label: 'Ian'},
    {value: 15, label: 'Hector'},
    {value: 10, label: 'Mauricio'},
    {value: 5, label: 'Leon'}
  ],
  formatter: function (x) { return x + "%"}
}).on('click', function(i, row){
  console.log(i, row);
});