HTMLWidgets.widget({

  name: "rWebPivotTable",

  type: "output",

  factory: function(el, width, height) {

    return {
      renderValue: function(x) {

        var el_id = document.getElementById(el.id);

        el_id.innerHTML = "<web-pivot-table />";

        var wpt = document.getElementsByTagName('web-pivot-table')[0];

       wpt.setOptions({
          localeFilePath: "./lang/",
          locale: "en",
          leavePageWarning: 0,
          limit: {
            sourceDataMaxRows: 500000,
            sourceDataMaxColumns: 1000,
            sourceDataMaxDataCells: 50000000
          }
      });
      
      wpt.setWptFromDataArray(
          x.attrArray,
          x.dataArray,
          "url"
      );


      },

      resize: function(width, height) {

      }
    };
  }
});
